import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class SearchResultsHeader extends StatelessWidget {
  const SearchResultsHeader({super.key, required this.count, required this.tabController});

  final int count;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SectionTitle(text: '$count results', color: AppColors.text),
        SizedBox(
          width: AppWidth.w110,
          child: TabBar(
            controller: tabController,
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.grey,
            tabs: const [Tab(icon: Icon(Icons.grid_view_rounded)), Tab(icon: Icon(Icons.view_list_rounded))],
          ),
        ),
      ],
    );
  }
}
