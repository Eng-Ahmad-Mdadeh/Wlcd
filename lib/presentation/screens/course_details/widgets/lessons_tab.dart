import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';
import 'package:wlcd/data/model/course_details/course_curriculum_section/course_curriculum_section_model.dart';

class LessonsTab extends StatelessWidget {
  const LessonsTab({super.key, required this.sections});
  final List<CourseCurriculumSectionModel> sections;

  @override
  Widget build(BuildContext context) {
    final ordered = [...sections]
      ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    return ListView(
      key: const PageStorageKey('lessons-tab-scroll'),
      padding: EdgeInsets.fromLTRB(
        AppPaddingWidth.p18,
        0,
        AppPaddingWidth.p18,
        AppPaddingHeight.p90,
      ),
      children: [
        if (ordered.isEmpty)
          const BodyTitle(text: 'No lessons available.', fontSize: 13),
        for (final section in ordered) ...[
          SectionTitle(
            text: section.title,
            fontSize: 16,
            color: AppColors.searchCardTitle,
          ),
          for (final lesson in ([
            ...section.lessons,
          ]..sort((a, b) => a.displayOrder.compareTo(b.displayOrder))))
            ListTile(
              leading: Icon(
                lesson.lessonType == 'video'
                    ? Icons.play_circle_outline
                    : Icons.article_outlined,
                color: AppColors.primary,
              ),
              title: BodyTitle(
                text: lesson.title,
                fontSize: 14,
                color: AppColors.searchCardTitle,
              ),
              subtitle: lesson.durationEstimateSeconds == null
                  ? null
                  : Text('${lesson.durationEstimateSeconds! ~/ 60} min'),
              trailing: lesson.isPreviewEligible
                  ? const Icon(Icons.visibility_outlined, size: 18)
                  : null,
            ),
          SizedBox(height: AppHeight.h14),
        ],
      ],
    );
  }
}
