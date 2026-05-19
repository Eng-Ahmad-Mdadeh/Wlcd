import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/custom_drop_down_widget.dart';
import 'package:wlcd/presentation/widgets/custom_search.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';

class SearchTopFilters extends StatelessWidget {
  const SearchTopFilters({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
    required this.onOpenFilter,
    required this.sortItems,
    required this.levelItems,
    required this.selectedSort,
    required this.selectedLevel,
    required this.onSortChanged,
    required this.onLevelChanged,
  });

  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onOpenFilter;
  final List<String> sortItems;
  final List<String> levelItems;
  final String selectedSort;
  final String selectedLevel;
  final ValueChanged<String> onSortChanged;
  final ValueChanged<String> onLevelChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSearch(color: AppColors.white, controller: searchController, onChanged: onSearchChanged),
        SizedBox(height: AppHeight.h10),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  side: BorderSide(color: AppColors.grey.withAlpha(80)),
                ),
                onPressed: onOpenFilter,
                icon: const Icon(Icons.tune, color: AppColors.primary),
                label: const BodyTitle(text: 'Filter', color: AppColors.primary),
              ),
            ),
            SizedBox(width: AppWidth.w8),
            Expanded(
              child: CustomDropDownWidget(
                onChanged: (value) => onSortChanged(value as String),
                hintText: 'Sort by',
                items: sortItems,
                isStringList: true,
                initialItem: selectedSort,
                color: AppColors.white,
              ),
            ),
            SizedBox(width: AppWidth.w8),
            Expanded(
              child: CustomDropDownWidget(
                onChanged: (value) => onLevelChanged(value as String),
                hintText: 'All levels',
                items: levelItems,
                isStringList: true,
                initialItem: selectedLevel,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
