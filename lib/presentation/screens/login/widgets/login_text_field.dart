import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/custom_text_from_field.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField({
    super.key,
    required this.icon,
    required this.hintText,
    required this.keyboardType,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
    this.controller,
  });

  final IconData icon;
  final String hintText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool obscureText;
  final IconData? suffixIcon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return CustomTextFromField(
      maxLines: 1,
      controller: controller,
      textInputType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      hintText: hintText,
      fontSize: AppFontSize.s15,
      hintColor: AppColors.loginFieldHint,
      cursorColor: AppColors.loginTabIndicator,
      filled: false,
      contentPaddingTop: AppPaddingHeight.p15,
      contentPaddingBottom: AppPaddingHeight.p15,
      contentPaddingStart: 0,
      prefixIcon: Icon(icon, size: AppSize.s20, color: AppColors.loginFieldIcon),
      suffixIcon: suffixIcon == null
          ? null
          : Icon(suffixIcon, size: AppSize.s20, color: AppColors.loginFieldIcon),
      enableInputBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.r8),
        borderSide: const BorderSide(color: AppColors.lightGrey),
      ),
      focusedInputBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.r8),
        borderSide: const BorderSide(color: AppColors.loginTabIndicator),
      ),
      errorInputBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.r8),
        borderSide: const BorderSide(color: AppColors.red),
      ),
    );
  }
}
