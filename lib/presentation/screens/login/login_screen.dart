import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/resources/app_colors.dart';
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
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: 375,
                height: 812,
                color: AppColors.white,
                padding: const EdgeInsets.fromLTRB(39, 18, 39, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LoginStatusBar(),
                    const SizedBox(height: 24),
                    const Icon(
                      Icons.arrow_back,
                      size: 18,
                      color: Color(0xFF1F2937),
                    ),
                    const SizedBox(height: 35),
                    const LoginHeaderSection(),
                    const SizedBox(height: 31),
                    const LoginTabs(),
                    const SizedBox(height: 27),
                    LoginFormSection(formKey: loginFormKey),
                    const SizedBox(height: 54),
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
