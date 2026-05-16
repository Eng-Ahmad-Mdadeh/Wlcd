import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart' show Iconsax;
import 'package:wlcd/core/extension/localization_extension.dart';
import 'package:wlcd/core/extension/validation_extension.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/core/routes/app_routes.dart';
import 'package:wlcd/presentation/cubit/remember_me/remember_me_cubit.dart';
import 'package:wlcd/presentation/widgets/auth/note_section.dart';
import 'package:wlcd/presentation/widgets/custom_rich_text.dart';
import 'package:wlcd/presentation/widgets/custom_submit_button.dart';

import '../../widgets/auth/logo_section.dart';
import '../../widgets/auth/field_section.dart';
import 'widgets/remember_me_checkbox.dart';

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
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  BodyLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginFormKey,
      child: Scaffold(
        appBar: AppBar(backgroundColor: AppColors.backGround),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              top: AppPaddingHeight.p27,
              start: AppPaddingWidth.p25,
              end: AppPaddingWidth.p25,
            ),
            child: Column(
              children: [
                const LogoSection(),
                FieldItem(
                  icon: Iconsax.sms_outline,
                  title: context.loc.email,
                  labelText: context.loc.enter_email,
                  textInputType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.loc.enter_email_required;
                    }
                    if (!value.isValidEmail) {
                      return context.loc.invalid_email;
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppHeight.h20),
                FieldItem(
                  icon: Iconsax.sms_outline,
                  title: context.loc.phone_number,
                  labelText: context.loc.enter_phone_number,
                  textInputType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.loc.enter_valid_phone;
                    }
                    if (!value.isValidEmail) {
                      return context.loc.enter_valid_phone;
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppHeight.h20),
                FieldItem(
                  icon: Iconsax.key_outline,
                  title: context.loc.password,
                  labelText: context.loc.enter_password,
                  textInputType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.loc.enter_password_required;
                    }
                    if (value.length < 6) {
                      return context.loc.password_min_length;
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppHeight.h20),
                const RememberMeCheckbox(),
                CustomSubmitButton(
                  title: context.loc.login,
                  marginTop: AppMarginHeight.m30,
                  onPressed: () {},
                ),
                NoteSection(
                  onTap: () {},
                  title: context.loc.forgot_password,
                  richTexts: [
                    CustomRichTextModel(
                      text: context.loc.dont_have_account,
                      color: AppColors.blackText,
                    ),
                    CustomRichTextModel(
                      text: context.loc.sign_up_now,
                      color: AppColors.lightPrimary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
