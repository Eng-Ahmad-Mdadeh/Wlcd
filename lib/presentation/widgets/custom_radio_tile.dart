import 'package:flutter/material.dart';

import 'package:wlcd/core/resources/app_colors.dart';

class CustomRadioTile<T> extends StatelessWidget {
  final T option;
  final T selectedOption;
  final Function(T) onChanged;
  final Widget? title;
  final Widget? supTitle;
  final EdgeInsetsGeometry? contentPadding;

  const CustomRadioTile({
    super.key,
    required this.option,
    required this.selectedOption,
    required this.onChanged,
    this.title,
    this.supTitle,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: AppColors.none,
        hoverColor: AppColors.none,
        highlightColor: AppColors.none,
      ),
      child: RadioListTile<T>(
        visualDensity: const VisualDensity(
          vertical: VisualDensity.minimumDensity,
          horizontal: VisualDensity.minimumDensity,
        ),
        enableFeedback: true,
        dense: true,
        contentPadding: contentPadding ?? EdgeInsets.zero,
        activeColor: AppColors.primary,
        subtitle: supTitle,
        title: title,
        value: option,
        groupValue: selectedOption,
        onChanged: (value) => onChanged(value as T),
      ),
    );
  }
}
