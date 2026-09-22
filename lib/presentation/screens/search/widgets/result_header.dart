import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class ResultHeader extends StatelessWidget {
  const ResultHeader({super.key, required this.resultCount});

  final int resultCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SectionTitle(
          text: '$resultCount results',
          fontSize: AppFontSize.s18,
          color: AppColors.searchResultTitle,
        ),
        Spacer(),
        Icon(Icons.view_list_rounded, size: 20, color: AppColors.primary),
      ],
    );
  }
}
