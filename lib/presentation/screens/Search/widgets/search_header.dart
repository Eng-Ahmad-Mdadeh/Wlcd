import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/custom_search.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: CustomSearch(
            color: AppColors.white,
            prefixIconColor: AppColors.searchIcon,
            hintColor: AppColors.searchHeaderText,
            borderRadius: 12,
          ),
        ),
        SizedBox(width: AppWidth.w12),
        const Icon(Icons.close, size: 24, color: AppColors.searchCloseIcon),
      ],
    );
  }
}
