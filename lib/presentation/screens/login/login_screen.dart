import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/extension/localization_extension.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/cubit/remember_me/remember_me_cubit.dart';
import 'package:wlcd/presentation/screens/login/widgets/login_form_section.dart';
import 'package:wlcd/presentation/screens/login/widgets/login_header_section.dart';
import 'package:wlcd/presentation/screens/login/widgets/login_home_indicator.dart';
import 'package:wlcd/presentation/screens/login/widgets/login_social_section.dart';
import 'package:wlcd/presentation/screens/login/widgets/login_status_bar.dart';
import 'package:wlcd/presentation/screens/login/widgets/login_tabs.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RememberMeCubit>(create: (context) => RememberMeCubit()),
      ],
      child: BodyLoginScreen(),
    );
  }
}

class BodyLoginScreen extends StatelessWidget {
  BodyLoginScreen({super.key});

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: context.loc.localeName == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: AppColors.loginBackground,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: AppWidth.w375,
                height: AppHeight.h812,
                color: AppColors.white,
                padding: EdgeInsets.fromLTRB(
                  AppWidth.w39,
                  AppHeight.h18,
                  AppWidth.w39,
                  AppHeight.h8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LoginStatusBar(),
                    SizedBox(height: AppHeight.h24),
                    Icon(
                      Icons.arrow_back,
                      size: AppSize.s18,
                      color: AppColors.loginBackIcon,
                    ),
                    SizedBox(height: AppHeight.h35),
                    const LoginHeaderSection(),
                    SizedBox(height: AppHeight.h31),
                    const LoginTabs(),
                    SizedBox(height: AppHeight.h27),
                    LoginFormSection(formKey: loginFormKey),
                    SizedBox(height: AppHeight.h54),
                    const LoginSocialSection(),
                    const Spacer(),
                    const LoginHomeIndicator(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
