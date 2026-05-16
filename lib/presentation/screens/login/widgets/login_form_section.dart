import 'package:flutter/material.dart';
import 'package:wlcd/core/extension/localization_extension.dart';
import 'package:wlcd/core/extension/validation_extension.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/login/widgets/login_text_field.dart';
import 'package:wlcd/presentation/widgets/custom_submit_button.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class LoginFormSection extends StatelessWidget {
  const LoginFormSection({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoginTextField(
            icon: Icons.email_outlined,
            hintText: context.loc.your_email,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => _validateEmail(context, value),
          ),
          SizedBox(height: AppHeight.h14),
          LoginTextField(
            icon: Icons.lock,
            hintText: context.loc.your_password,
            obscureText: true,
            suffixIcon: Icons.visibility_off_outlined,
            keyboardType: TextInputType.visiblePassword,
            validator: (value) => _validatePassword(context, value),
          ),
          SizedBox(height: AppHeight.h10),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              foregroundColor: AppColors.loginTabIndicator,
            ),
            child: SectionTitle(
              text: context.loc.forgot_password,
              color: AppColors.loginTabIndicator,
              fontSize: AppFontSize.s15,
              fontWeight: AppFontWeight.bold,
            ),
          ),
          CustomSubmitButton(
            title: context.loc.sign_in,
            marginTop: AppMarginHeight.m29,
            height: AppHeight.h49,
            borderRadius: AppRadius.r24,
            elevation: 0,
            buttonColor: AppColors.loginPrimary,
            onPressed: () => formKey.currentState?.validate(),
          ),
        ],
      ),
    );
  }

  String? _validateEmail(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.loc.enter_email_validation;
    }
    if (!value.isValidEmail) {
      return context.loc.invalid_email_validation;
    }
    return null;
  }

  String? _validatePassword(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return context.loc.enter_password_validation;
    }
    if (value.length < 6) {
      return context.loc.short_password_validation;
    }
    return null;
  }
}
