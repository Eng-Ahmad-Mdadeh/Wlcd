import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/custom_text_from_field.dart';

class InfoTextField extends StatelessWidget {
  final String label;
  final String? initValue;
  final IconData icon;
  final int? maxLines;
  final bool? readeOnly;
  final double? height;
  final Function(String)? onChanged;

  const InfoTextField({
    super.key,
    required this.label,
    this.initValue,
    required this.icon,
    this.maxLines,
    this.readeOnly = false,
    this.height,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? AppHeight.h50,
      child: CustomTextFromField(
        readOnly: readeOnly,
        unFocus: false,
        initialValue: initValue,
        contentPaddingStart: AppPaddingWidth.p10,
        contentPaddingEnd: AppPaddingWidth.p10,
        contentPaddingTop: AppPaddingHeight.p17,
        maxLines: maxLines ?? 1,
        onChanged: onChanged,
        borderRadius: AppRadius.r7,
        labelText: label,
        prefixIcon: Icon(
          icon,
          size: AppSize.s23,
        ),
        enableInputBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.r13),
          borderSide: const BorderSide(color: AppColors.lightGrey),
        ),
        focusedInputBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.r13),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        errorInputBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.r13),
          borderSide: const BorderSide(color: AppColors.red),
        ),
      ),
    );
  }
}
