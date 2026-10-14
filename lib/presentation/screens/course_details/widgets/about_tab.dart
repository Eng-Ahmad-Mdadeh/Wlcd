import 'package:wlcd/data/model/course_details/course_overview/course_overview_model.dart';
import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class AboutTab extends StatelessWidget {
  const AboutTab({super.key, required this.description, this.overview});

  final String description;
  final CourseOverviewModel? overview;

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const PageStorageKey('about-tab-scroll'),
      padding: EdgeInsets.fromLTRB(
        AppPaddingWidth.p18,
        0,
        AppPaddingWidth.p18,
        AppPaddingHeight.p90,
      ),
      children: [
        if (overview?.subtitle != null)
          SectionTitle(text: overview!.subtitle!, fontSize: 16),
        if (overview?.instructor != null) ...[
          SectionTitle(text: overview!.instructor!.displayName, fontSize: 16),
          if (overview!.instructor!.headline != null)
            Text(overview!.instructor!.headline!),
        ],
        if (overview?.price != null) Text(overview!.price!.displayLabel),
        const SectionTitle(
          text: 'Descriptions',
          fontSize: 18,
          color: AppColors.searchCardTitle,
        ),
        const SizedBox(height: 8),
        BodyTitle(
          text: overview?.description ?? description,
          fontSize: 13,
          color: AppColors.searchRatingText,
          maxLines: 20,
        ),
      ],
    );
  }
}
