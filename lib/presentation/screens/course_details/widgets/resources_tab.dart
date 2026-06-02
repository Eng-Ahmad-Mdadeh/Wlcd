import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class ResourcesTab extends StatelessWidget {
  const ResourcesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const PageStorageKey('resources-tab-scroll'),
      padding: EdgeInsets.fromLTRB(AppPaddingWidth.p18, 0, AppPaddingWidth.p18, AppPaddingHeight.p90),
      children: [
        const SectionTitle(text: 'Resources', fontSize: 18, color: AppColors.searchCardTitle),
        SizedBox(height: AppHeight.h12),
        Container(
          padding: EdgeInsets.all(AppPaddingWidth.p16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.searchCardBorder),
            borderRadius: BorderRadius.circular(AppRadius.r14),
          ),
          child: const BodyTitle(
            text: 'Course files and references will appear here.',
            fontSize: 13,
            color: AppColors.searchRatingText,
            maxLines: 3,
          ),
        ),
      ],
    );
  }
}
