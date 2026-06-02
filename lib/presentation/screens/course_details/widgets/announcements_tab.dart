import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class AnnouncementsTab extends StatelessWidget {
  const AnnouncementsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const PageStorageKey('announcements-tab-scroll'),
      padding: EdgeInsets.fromLTRB(AppPaddingWidth.p18, 0, AppPaddingWidth.p18, AppPaddingHeight.p90),
      children: [
        const SectionTitle(text: 'Announcements', fontSize: 18, color: AppColors.searchCardTitle),
        SizedBox(height: AppHeight.h12),
        Container(
          padding: EdgeInsets.all(AppPaddingWidth.p16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.searchCardBorder),
            borderRadius: BorderRadius.circular(AppRadius.r14),
          ),
          child: const BodyTitle(
            text: 'No new announcements are available for this course yet.',
            fontSize: 13,
            color: AppColors.searchRatingText,
            maxLines: 3,
          ),
        ),
      ],
    );
  }
}
