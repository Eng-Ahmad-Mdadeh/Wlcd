import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class AboutTab extends StatelessWidget {
  const AboutTab({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const PageStorageKey('about-tab-scroll'),
      padding: EdgeInsets.fromLTRB(AppPaddingWidth.p18, 0, AppPaddingWidth.p18, AppPaddingHeight.p90),
      children: [
        const SectionTitle(text: 'Descriptions', fontSize: 18, color: AppColors.searchCardTitle),
        const SizedBox(height: 8),
        BodyTitle(
          text: description,
          fontSize: 13,
          color: AppColors.searchRatingText,
          maxLines: 20,
        ),
      ],
    );
  }
}
