import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/custom_drop_down_widget.dart';
import 'package:wlcd/presentation/widgets/custom_filter_chip.dart';

class FilterRow extends StatelessWidget {
  const FilterRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomFilterChip(
            text: 'Filter',
            selected: false,
            onSelected: (_) {},
            side: const BorderSide(color: AppColors.searchFilterBorder),
            padding: EdgeInsets.symmetric(vertical: AppPaddingHeight.p10),
          ),
        ),
        SizedBox(width: AppWidth.w8),
        Expanded(
          child: CustomDropDownWidget(
            onChanged: (_) {},
            hintText: 'Sort by',
            items: const ['Sort by', 'Most Popular', 'Newest'],
            isStringList: true,
            height: AppHeight.h38,
            color: AppColors.white,
            borderRadius: AppRadius.r10,
            topPadding: AppPaddingHeight.p8,
            bottomPadding: AppPaddingHeight.p8,
          ),
        ),
        SizedBox(width: AppWidth.w8),
        Expanded(
          child: CustomDropDownWidget(
            onChanged: (_) {},
            hintText: 'All levels',
            items: const ['All levels', 'Beginner', 'Intermediate', 'Advanced'],
            isStringList: true,
            height: AppHeight.h38,
            color: AppColors.white,
            borderRadius: AppRadius.r10,
            topPadding: AppPaddingHeight.p8,
            bottomPadding: AppPaddingHeight.p8,
          ),
        ),
      ],
    );
  }
}
