import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
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
  });

  final IconData icon;
  final String hintText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool obscureText;
  final IconData? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return CustomTextFromField(
      maxLines: 1,
      textInputType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      hintText: hintText,
      fontSize: 15,
      hintColor: const Color(0xFF9CA6B6),
      cursorColor: const Color(0xFF232A62),
      filled: false,
      contentPaddingTop: 15,
      contentPaddingBottom: 15,
      contentPaddingStart: 0,
      prefixIcon: Icon(icon, size: 15, color: const Color(0xFFA8B0BD)),
      suffixIcon: suffixIcon == null
          ? null
          : Icon(suffixIcon, size: 15, color: const Color(0xFFA8B0BD)),
      enableInputBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFEDF0F4)),
      ),
      focusedInputBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF232A62)),
      ),
      errorInputBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.red),
      ),
    );
  }
}
