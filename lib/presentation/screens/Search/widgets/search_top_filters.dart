import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/custom_drop_down_widget.dart';
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
        Row(
          children: [
            Expanded(
              child: Container(
                height: AppHeight.h50,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppRadius.r10),
                  border: Border.all(color: AppColors.lightGrey),
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: onSearchChanged,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, size: 20, color: AppColors.grey),
                    hintText: 'Search something',
                  ),
                ),
              ),
            ),
            IconButton(onPressed: () { searchController.clear(); onSearchChanged(''); }, icon: const Icon(Icons.close, color: AppColors.greyText)),
          ],
        ),
        SizedBox(height: AppHeight.h10),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(backgroundColor: AppColors.white, side: BorderSide(color: AppColors.lightGrey), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.r8))),
                onPressed: onOpenFilter,
                icon: const Icon(Icons.tune, size: 14, color: AppColors.greyText),
                label: const BodyTitle(text: 'Filter', color: AppColors.greyText, fontSize: 12),
              ),
            ),
            SizedBox(width: AppWidth.w8),
            Expanded(child: CustomDropDownWidget(onChanged: (v)=>onSortChanged(v as String), hintText: 'Sort by', items: sortItems, isStringList: true, initialItem: selectedSort, color: AppColors.white, height: AppHeight.h38)),
            SizedBox(width: AppWidth.w8),
            Expanded(child: CustomDropDownWidget(onChanged: (v)=>onLevelChanged(v as String), hintText: 'All levels', items: levelItems, isStringList: true, initialItem: selectedLevel, color: AppColors.white, height: AppHeight.h38)),
          ],
        ),
      ],
    );
  }
}
