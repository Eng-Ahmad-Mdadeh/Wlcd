import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class ResultHeader extends StatelessWidget {
  const ResultHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SectionTitle(
          text: '10,000 results',
          fontSize: 23,
          fontWeight: FontWeight.w600,
          color: AppColors.searchResultTitle,
        ),
        Spacer(),
        Icon(Icons.grid_view_rounded, size: 20, color: AppColors.searchInactiveView),
        SizedBox(width: 10),
        Icon(Icons.view_list_rounded, size: 20, color: AppColors.primary),
      ],
    );
  }
}
