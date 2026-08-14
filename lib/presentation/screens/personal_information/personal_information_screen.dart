import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:wlcd/core/resources/app_assets.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/core/routes/app_routes_imports.dart';
import 'package:wlcd/data/model/profile/profile_model.dart';
import 'package:wlcd/presentation/bloc/profile/get_profile/get_profile_bloc.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';
import 'package:wlcd/presentation/widgets/loading_widget.dart';
import 'package:wlcd/presentation/widgets/retry_widget.dart';

import 'widgets/info_text_field.dart';
import 'widgets/picture_section.dart';
import 'widgets/save_button_section.dart';

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetProfileBloc()..add(const SubmitGetProfileEvent()),
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

class _PersonalInformationContent extends StatelessWidget {
  const _PersonalInformationContent({required this.profile});

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                  onChanged: (p0) {},
                ),
                InfoTextField(
                  label: "البريد الإلكتروني",
                  icon: Iconsax.sms_outline,
                  initValue: profile.email ?? '',
                  onChanged: (p0) {},
                ),
                InfoTextField(
                  label: "رقم الهاتف",
                  icon: Iconsax.call_outline,
                  initValue: profile.phone ?? '',
                  onChanged: (p0) {},
                ),
              ],
            ),
          ),
        ),
        PositionedDirectional(
          start: 0,
          end: 0,
          bottom: 0,
          child: SaveButtonSection(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
        ),
      ],
    );
  }
}
