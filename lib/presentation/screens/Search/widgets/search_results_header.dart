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
    final isGrid = tabController.index == 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SectionTitle(text: isGrid ? 'Popular Courses' : '10,000 results', color: AppColors.blackText , fontSize: 20),
        SizedBox(
          width: AppWidth.w70,
          child: TabBar(
            controller: tabController,
            dividerColor: Colors.transparent,
            indicatorColor: Colors.transparent,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.grey,
            tabs: const [Tab(icon: Icon(Icons.grid_view_rounded, size: 18)), Tab(icon: Icon(Icons.view_list_rounded, size: 18))],
          ),
        ),
      ],
    );
  }
}
