import 'package:flutter/material.dart';
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
            hintText: 'Your email',
            keyboardType: TextInputType.emailAddress,
            validator: _validateEmail,
          ),
          SizedBox(height: AppHeight.h14),
          LoginTextField(
            icon: Icons.lock,
            hintText: 'Your password',
            obscureText: true,
            suffixIcon: Icons.visibility_off_outlined,
            keyboardType: TextInputType.visiblePassword,
            validator: _validatePassword,
          ),
          SizedBox(height: AppHeight.h1),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              foregroundColor: AppColors.loginTabIndicator,
            ),
            child: SectionTitle(
              text: 'Forgot Password?',
              color: AppColors.loginTabIndicator,
              fontSize: AppFontSize.s14,
              fontWeight: AppFontWeight.bold,
            ),
          ),
          CustomSubmitButton(
            title: 'Sign In',
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

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!value.isValidEmail) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
