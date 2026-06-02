import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class ReviewsTab extends StatelessWidget {
  const ReviewsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(AppPaddingWidth.p18, 0, AppPaddingWidth.p18, AppPaddingHeight.p90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(text: 'Ratings', fontSize: 18, color: AppColors.searchCardTitle),
          SizedBox(height: AppHeight.h12),
          Container(
            padding: EdgeInsets.all(AppPaddingWidth.p16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.searchCardBorder),
              borderRadius: BorderRadius.circular(AppRadius.r14),
            ),
            child: Column(
              children: [
                const BodyTitle(text: 'Customer Review', fontSize: 22, color: AppColors.searchCardTitle),
                SizedBox(height: AppHeight.h8),
                const BodyTitle(text: '⭐⭐⭐⭐⭐  4.5 out of 5', fontSize: 14, color: AppColors.searchRatingText),
              ],
            ),
          ),
          SizedBox(height: AppHeight.h18),
          const SectionTitle(text: 'User reviews', fontSize: 18, color: AppColors.searchCardTitle),
          SizedBox(height: AppHeight.h10),
          const BodyTitle(
            text:
            'Merrill Kervin\n3 weeks ago\n\nPulvinar nisl blandit cras lacus diam posuere. Varius sem vestibulum egestas ultricies.',
            fontSize: 13,
            color: AppColors.searchRatingText,
          ),
        ],
      ),
    );
  }
}
