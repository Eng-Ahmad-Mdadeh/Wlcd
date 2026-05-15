import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../core/resources/app_colors.dart';
import '../../core/resources/app_values.dart';
import 'package:wlcd/core/extension/localization_extension.dart';
import 'custom_text_from_field.dart';

class CustomSearch extends StatelessWidget {
  final Color color;
  final Color prefixIconColor;
  final Color hintColor;
  final double? paddingEnd;
  final double? paddingStart;
  final double? paddingBottom;
  final double? paddingTop;
  final double? borderRadius;
  final bool? readOnly;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Function()? onTap;
  final TextEditingController? controller;

  const CustomSearch({
    super.key,
    required this.color,
    this.paddingEnd,
    this.paddingStart,
    this.paddingBottom,
    this.paddingTop,
    this.borderRadius,
    this.readOnly = false,
    this.prefixIconColor = AppColors.primary,
    this.hintColor = AppColors.greyText,
    this.controller,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        end: paddingEnd ?? 0,
        start: paddingStart ?? 0,
        bottom: paddingBottom ?? 0,
        top: paddingTop ?? 0,
      ),
      child: SizedBox(
        width: double.infinity,
        height: AppHeight.h50,
        child: CustomTextFromField(
          maxLines: 1,
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
          controller: controller,
          contentPaddingTop: AppPaddingHeight.p17,
          readOnly: readOnly,
          prefixIcon: Icon(
            Iconsax.search_normal_outline,
            color: AppColors.primary,
            size: AppSize.s27,
          ),
          hintColor: hintColor,
          onTap: onTap,
          borderRadius: borderRadius ?? AppRadius.r45,
          hintText: "search_hint",
          color: color,
        ),
      ),
    );
  }
}
