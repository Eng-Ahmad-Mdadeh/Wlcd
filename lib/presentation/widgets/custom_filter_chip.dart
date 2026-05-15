import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';

class CustomFilterChip extends StatelessWidget {
  final String text;
  final bool selected;
  final ValueChanged<bool> onSelected;

  // Optional tweaks
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final BorderSide side;
  final bool showCheckmark;

  const CustomFilterChip({
    super.key,
    required this.text,
    required this.selected,
    required this.onSelected,
    this.padding,
    this.fontSize,
    this.side = const BorderSide(color: AppColors.lightGrey, width: .5),
    this.showCheckmark = false,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: BodyTitle(
        text: text,
        color: selected ? AppColors.white : AppColors.blackText,
        fontSize: fontSize,
      ),
      selected: selected,
      onSelected: onSelected,
      side: side,
      showCheckmark: showCheckmark,
      // Keep the same behavior you had: primary when selected, searchColor otherwise
      color: WidgetStateProperty.resolveWith<Color?>((states) {
        return selected ? AppColors.primary : AppColors.searchColor;
      }),
      selectedColor: AppColors.primary,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: padding, // optional, null keeps default density
    );
  }
}
