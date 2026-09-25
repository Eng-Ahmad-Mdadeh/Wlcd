import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';

class CustomFilterChip extends StatelessWidget {
  final String text;
  final bool selected;
  final ValueChanged<bool> onSelected;

  // Optional tweaks
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final BorderSide side;
  final bool showCheckmark;
  final Color? selectedColor;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? selectedTextColor;
  final double? borderRadius;

  const CustomFilterChip({
    super.key,
    required this.text,
    required this.selected,
    required this.onSelected,
    this.padding,
    this.fontSize,
    this.side = const BorderSide(color: AppColors.lightGrey, width: .5),
    this.showCheckmark = false,
    this.selectedColor,
    this.backgroundColor,
    this.textColor,
    this.selectedTextColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: BodyTitle(
        text: text,
        color: selected
            ? selectedTextColor ?? AppColors.white
            : textColor ?? AppColors.blackText,
        fontSize: fontSize,
      ),
      selected: selected,
      onSelected: onSelected,
      side: side,
      showCheckmark: showCheckmark,
      color: WidgetStateProperty.resolveWith<Color?>((states) {
        return selected
            ? selectedColor ?? AppColors.primary
            : backgroundColor ?? AppColors.searchColor;
      }),
      selectedColor: selectedColor ?? AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? AppRadius.r8),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: padding,
    );
  }
}
