import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/extension/localization_extension.dart';
import 'package:wlcd/core/extension/validation_extension.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/core/routes/app_routes.dart';
import 'package:wlcd/presentation/cubit/code_check/code_check_cubit.dart';
import 'package:wlcd/presentation/screens/login/widgets/forgot_password_bottom_sheet.dart';
import 'package:wlcd/presentation/screens/login/widgets/login_text_field.dart';
import 'package:wlcd/presentation/widgets/custom_submit_button.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class LoginFormSection extends StatefulWidget {
  const LoginFormSection({super.key, required this.formKey, required this.isPhoneLogin});

  final GlobalKey<FormState> formKey;
  final bool isPhoneLogin;

  @override
  State<LoginFormSection> createState() => _LoginFormSectionState();
}

class _LoginFormSectionState extends State<LoginFormSection> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.isPhoneLogin) ...[
            LoginTextField(
              controller: _phoneController,
              icon: Icons.phone_outlined,
              hintText: context.loc.enter_phone_number,
              keyboardType: TextInputType.phone,
              // validator: (value) => _validatePhone(context, value),
            ),
          ] else ...[
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
            SizedBox(height: AppHeight.h14),
            TextButton(
              onPressed: () => showForgotPasswordBottomSheet(context),
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
          ],
          CustomSubmitButton(
            title: context.loc.sign_in,
            marginTop: AppMarginHeight.m30,
            borderRadius: AppRadius.r24,
            buttonColor: AppColors.loginPrimary,
            onPressed: () {
              if (widget.formKey.currentState!.validate()) {
                if (widget.isPhoneLogin) {
                  context.read<CodeCheckCubit>()
                    ..setPhone(_phoneController.text.trim())
                    ..setType('sms', '');
                  CheckCodeRoute().push(context);
                } else {
                  HomeRoute().push(context);
                }
              }
            },
          ),
          SizedBox(height: AppHeight.h26),
          const _LoginOrDivider(),
          SizedBox(height: AppHeight.h22),
          const _CreateAccountButton(),
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

  // String? _validatePhone(BuildContext context, String? value) {
  //   if (value == null || value.isEmpty || !value.isValidPhone) {
  //     return context.loc.enter_valid_phone;
  //   }
  //   return null;
  // }

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

class _LoginOrDivider extends StatelessWidget {
  const _LoginOrDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.loginDivider, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppWidth.w12),
          child: SectionTitle(
            text: 'أو',
            color: AppColors.loginDarkText,
            fontSize: AppFontSize.s18,
            fontWeight: AppFontWeight.bold,
          ),
        ),
        const Expanded(child: Divider(color: AppColors.loginDivider, thickness: 1)),
      ],
    );
  }
}

class _CreateAccountButton extends StatelessWidget {
  const _CreateAccountButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, AppHeight.h60),
        elevation: 0,
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.r12)),
      ),
      child: Text.rich(
        TextSpan(
          text: 'هل أنت جديد على Wlcd? ',
          children: [
            TextSpan(
              text: 'إنشاء حساب!',
              style: TextStyle(fontWeight: AppFontWeight.extraBold),
            ),
          ],
        ),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.white,
          fontSize: AppFontSize.s18,
          fontWeight: AppFontWeight.bold,
        ),
      ),
    );
  }
}
