import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:wlcd/core/resources/app_assets.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/core/routes/app_routes_imports.dart';
import 'package:wlcd/data/model/profile/profile_model.dart';
import 'package:wlcd/domain/entity/profile/upload_avatar_entity.dart';
import 'package:wlcd/presentation/bloc/profile/get_profile/get_profile_bloc.dart';
import 'package:wlcd/presentation/bloc/profile/add_email_identifier/add_email_identifier_bloc.dart';
import 'package:wlcd/presentation/bloc/profile/change_email/change_email_bloc.dart';
import 'package:wlcd/presentation/bloc/profile/add_phone_identifier/add_phone_identifier_bloc.dart';
import 'package:wlcd/presentation/bloc/profile/change_phone/change_phone_bloc.dart';
import 'package:wlcd/presentation/bloc/profile/update_profile/update_profile_bloc.dart';
import 'package:wlcd/presentation/bloc/profile/upload_avatar/upload_avatar_bloc.dart';
import 'package:wlcd/presentation/cubit/upload_avatar/upload_avatar_cubit.dart';
import 'package:wlcd/presentation/cubit/update_profile/update_profile_cubit.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';
import 'package:wlcd/presentation/widgets/custom_snack_bar.dart';
import 'package:wlcd/presentation/widgets/loading_widget.dart';
import 'package:wlcd/presentation/widgets/retry_widget.dart';

import 'widgets/info_text_field.dart';
import 'widgets/email_identifier_bottom_sheet.dart';
import 'widgets/phone_identifier_bottom_sheet.dart';
import 'widgets/picture_section.dart';
import 'widgets/save_button_section.dart';

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetProfileBloc()..add(const SubmitGetProfileEvent())),
        BlocProvider(create: (_) => UpdateProfileBloc()),
        BlocProvider(create: (_) => UploadAvatarBloc()),
        BlocProvider(create: (_) => UploadAvatarCubit()),
        BlocProvider(create: (_) => AddEmailIdentifierBloc()),
        BlocProvider(create: (_) => ChangeEmailBloc()),
        BlocProvider(create: (_) => AddPhoneIdentifierBloc()),
        BlocProvider(create: (_) => ChangePhoneBloc()),
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
      appBar: const CustomAppBar(title: "المعلومات الشخصية", showBackButton: true),
      body: BlocBuilder<GetProfileBloc, IGetProfileState>(
        builder: (context, state) {
          if (state is GetProfileLoaded && state.profileModel?.data != null) {
            final profile = state.profileModel!.data!;
            return BlocProvider(
              create: (_) => UpdateProfileCubit(profile),
              child: _PersonalInformationContent(profile: profile),
            );
          }

          if (state is GetProfileFailed || state is GetProfileLoaded) {
            return RetryWidget(onReload: () => context.read<GetProfileBloc>().add(const SubmitGetProfileEvent()));
          }

          return const LoadingWidget(0);
        },
      ),
    );
  }
}

class _PersonalInformationContent extends StatelessWidget {
  const _PersonalInformationContent({required this.profile});

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UpdateProfileBloc, IUpdateProfileState>(listener: _onUpdateProfileState),
        BlocListener<UploadAvatarBloc, IUploadAvatarState>(listener: _onUploadAvatarState),
        BlocListener<UploadAvatarCubit, UploadAvatarEntity>(listener: _onAvatarChanged),
      ],
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
                  BlocBuilder<UploadAvatarCubit, UploadAvatarEntity>(
                    builder: (context, avatar) => BlocBuilder<UploadAvatarBloc, IUploadAvatarState>(
                      builder: (context, state) => PictureSection(
                        image: _avatarPath(avatar) ?? profile.avatar?.url ?? AppAssets.logo,
                        isLoading: state is UploadAvatarLoading,
                        onTap: state is UploadAvatarLoading ? null : context.read<UploadAvatarCubit>().avatarChanged,
                      ),
                    ),
                  ),
                  SizedBox(height: AppHeight.h1),
                  InfoTextField(
                    label: "الإسم الكامل",
                    icon: Iconsax.user_outline,
                    initValue: profile.displayName,
                    onChanged: context.read<UpdateProfileCubit>().setDisplayName,
                  ),
                  InfoTextField(
                    readeOnly: true,
                    label: "البريد الإلكتروني",
                    icon: Iconsax.sms_outline,
                    initValue: profile.email ?? '',
                    suffixIcon: const Icon(Icons.edit_outlined),
                    onTap: () => showEmailIdentifierBottomSheet(
                      context,
                      currentEmail: profile.email,
                      onSuccess: () => context.read<GetProfileBloc>().add(
                        const SubmitGetProfileEvent(),
                      ),
                    ),
                  ),
                  InfoTextField(
                    readeOnly: true,
                    label: "رقم الهاتف",
                    icon: Iconsax.call_outline,
                    initValue: profile.phone ?? '',
                    suffixIcon: const Icon(Icons.edit_outlined),
                    onTap: () => showPhoneIdentifierBottomSheet(
                      context,
                      currentPhone: profile.phone,
                      onSuccess: () => context.read<GetProfileBloc>().add(
                        const SubmitGetProfileEvent(),
                      ),
                    ),
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
                onPressed: state is UpdateProfileLoading ? null : () => _updateProfile(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateProfile(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    final updateProfileCubit = context.read<UpdateProfileCubit>()..prepareForSubmission();
    context.read<UpdateProfileBloc>().add(SubmitUpdateProfileEvent(updateProfileCubit.state));
  }

  String? _avatarPath(UploadAvatarEntity avatar) {
    if (avatar.file case [final file, ...]) {
      return file['path'] as String?;
    }
    return null;
  }

  void _onAvatarChanged(BuildContext context, UploadAvatarEntity avatar) {
    if (avatar.file?.isNotEmpty ?? false) {
      context.read<UploadAvatarBloc>().add(SubmitUploadAvatarEvent(avatar));
    }
  }

  void _onUpdateProfileState(BuildContext context, IUpdateProfileState state) {
    if (state is UpdateProfileLoaded) {
      showCustomSnackBar(
        context: context,
        title: 'تم بنجاح',
        message: state.profileModel?.message ?? 'تم حفظ المعلومات الشخصية',
        contentType: ContentType.success,
      );
      context.read<GetProfileBloc>().add(const SubmitGetProfileEvent());
    } else if (state is UpdateProfileFailed) {
      showCustomSnackBar(context: context, title: 'خطأ', message: state.message, contentType: ContentType.failure);
    }
  }

  void _onUploadAvatarState(BuildContext context, IUploadAvatarState state) {
    if (state is UploadAvatarLoaded) {
      showCustomSnackBar(
        context: context,
        title: 'تم بنجاح',
        message: state.profileModel?.message ?? 'تم تحديث الصورة الشخصية',
        contentType: ContentType.success,
      );
      context.read<GetProfileBloc>().add(const SubmitGetProfileEvent());
    } else if (state is UploadAvatarFailed) {
      showCustomSnackBar(context: context, title: 'خطأ', message: state.message, contentType: ContentType.failure);
    }
  }
}
