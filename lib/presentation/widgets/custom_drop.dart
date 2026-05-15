import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';

class CustomDrop extends StatelessWidget {
  final ValueChanged<dynamic> onChanged;
  final String hintText;
  final List<dynamic>? items;
  final Widget? prefixIcon;
  final String? initItem;
  final bool isStringList;
  final Color? borderColor;
  final double borderRadius;

  const CustomDrop({
    super.key,
    required this.onChanged,
    required this.hintText,
    this.initItem,
    required this.items,
    required this.borderRadius,
    this.prefixIcon,
    this.borderColor,
    this.isStringList = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDropdown<dynamic>.search(
      initialItem: initItem,
      onChanged: onChanged,
      closedHeaderPadding: EdgeInsets.symmetric(
        horizontal: AppPaddingWidth.p20,
        vertical: AppPaddingHeight.p17,
      ),
      decoration: CustomDropdownDecoration(
        hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: AppColors.grey,
              fontSize: AppFontSize.s16,
            ),
        listItemStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: AppColors.blackCow,
              fontSize: AppFontSize.s16,
            ),
        headerStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: AppColors.primary,
              fontSize: AppFontSize.s16,
            ),
        closedBorder: Border.all(color: borderColor ?? Colors.transparent),

        closedFillColor: AppColors.backGround,
        prefixIcon: prefixIcon,
        closedBorderRadius: BorderRadius.circular(borderRadius),
        expandedBorderRadius: BorderRadius.circular(borderRadius),
      ),
      items: isStringList ? items : items!.map((e) => e.value!).toList(),
      hintText: hintText,
    );
  }
}
