import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:wlcd/core/resources/app_assets.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/core/routes/app_routes_imports.dart';
import 'package:wlcd/data/model/profile/profile_model.dart';
import 'package:wlcd/domain/entity/profile/update_profile_entity.dart';
import 'package:wlcd/presentation/bloc/profile/get_profile/get_profile_bloc.dart';
import 'package:wlcd/presentation/bloc/profile/update_profile/update_profile_bloc.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';
import 'package:wlcd/presentation/widgets/custom_snack_bar.dart';
import 'package:wlcd/presentation/widgets/loading_widget.dart';
import 'package:wlcd/presentation/widgets/retry_widget.dart';

import 'widgets/info_text_field.dart';
import 'widgets/picture_section.dart';
import 'widgets/save_button_section.dart';

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GetProfileBloc()..add(const SubmitGetProfileEvent()),
        ),
        BlocProvider(create: (_) => UpdateProfileBloc()),
      ],
      child: const BodyPersonalInformationScreen(),
    );
  }
}

class BodyPersonalInformationScreen extends StatelessWidget {
  const BodyPersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "المعلومات الشخصية",
        showBackButton: true,
      ),
      body: BlocBuilder<GetProfileBloc, IGetProfileState>(
        builder: (context, state) {
          if (state is GetProfileLoaded && state.profileModel?.data != null) {
            return _PersonalInformationContent(
              profile: state.profileModel!.data!,
            );
          }

          if (state is GetProfileFailed || state is GetProfileLoaded) {
            return RetryWidget(
              onReload: () => context.read<GetProfileBloc>().add(
                const SubmitGetProfileEvent(),
              ),
            );
          }

          return const LoadingWidget(0);
        },
      ),
    );
  }
}

class _PersonalInformationContent extends StatefulWidget {
  const _PersonalInformationContent({required this.profile});

  final ProfileModel profile;

  @override
  State<_PersonalInformationContent> createState() =>
      _PersonalInformationContentState();
}

class _PersonalInformationContentState
    extends State<_PersonalInformationContent> {
  late String _displayName;
  late String _email;
  late String _phone;

  ProfileModel get profile => widget.profile;

  @override
  void initState() {
    super.initState();
    _setValuesFromProfile();
  }

  @override
  void didUpdateWidget(covariant _PersonalInformationContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.profile != widget.profile) _setValuesFromProfile();
  }

  void _setValuesFromProfile() {
    _displayName = profile.displayName;
    _email = profile.email ?? '';
    _phone = profile.phone ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateProfileBloc, IUpdateProfileState>(
      listener: _onUpdateProfileState,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                bottom: AppPaddingHeight.p100,
                start: AppPaddingWidth.p20,
                end: AppPaddingWidth.p20,
              ),
              child: Column(
                spacing: AppHeight.h20,
                children: [
                  PictureSection(image: profile.avatar?.url ?? AppAssets.logo),
                  SizedBox(height: AppHeight.h1),
                  InfoTextField(
                    label: "الإسم الكامل",
                    icon: Iconsax.user_outline,
                    initValue: profile.displayName,
                    onChanged: (value) => _displayName = value,
                  ),
                  InfoTextField(
                    label: "البريد الإلكتروني",
                    icon: Iconsax.sms_outline,
                    initValue: profile.email ?? '',
                    onChanged: (value) => _email = value,
                  ),
                  InfoTextField(
                    label: "رقم الهاتف",
                    icon: Iconsax.call_outline,
                    initValue: profile.phone ?? '',
                    onChanged: (value) => _phone = value,
                  ),
                ],
              ),
            ),
          ),
          PositionedDirectional(
            start: 0,
            end: 0,
            bottom: 0,
            child: BlocBuilder<UpdateProfileBloc, IUpdateProfileState>(
              builder: (context, state) => SaveButtonSection(
                isLoading: state is UpdateProfileLoading,
                onPressed: state is UpdateProfileLoading
                    ? null
                    : () => _updateProfile(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateProfile(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    context.read<UpdateProfileBloc>().add(
      SubmitUpdateProfileEvent(
        UpdateProfileEntity(
          displayName: _displayName.trim(),
          email: _email.trim(),
          phone: _phone.trim(),
          locale: profile.locale,
          idempotencyKey:
              'update-profile-${DateTime.now().microsecondsSinceEpoch}',
          ifMatch: profile.etag ?? '*',
        ),
      ),
    );
  }

  void _onUpdateProfileState(
    BuildContext context,
    IUpdateProfileState state,
  ) {
    if (state is UpdateProfileLoaded) {
      showCustomSnackBar(
        context: context,
        title: 'تم بنجاح',
        message: state.profileModel?.message ?? 'تم حفظ المعلومات الشخصية',
        contentType: ContentType.success,
      );
      context.read<GetProfileBloc>().add(const SubmitGetProfileEvent());
    } else if (state is UpdateProfileFailed) {
      showCustomSnackBar(
        context: context,
        title: 'خطأ',
        message: state.message,
        contentType: ContentType.failure,
      );
    }
  }
}
