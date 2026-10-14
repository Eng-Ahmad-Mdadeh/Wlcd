import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/data/model/course_details/course_curriculum_section/course_curriculum_section_model.dart';
import 'package:wlcd/data/model/course_details/course_curriculum_lesson/course_curriculum_lesson_model.dart';

class LessonsTab extends StatelessWidget {
  const LessonsTab({super.key, required this.sections});
  final List<CourseCurriculumSectionModel> sections;
  @override
  Widget build(BuildContext context) {
    final ordered = [...sections]
      ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    final lessons = [
      for (final section in ordered)
        ...([...section.lessons]
          ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder))),
    ];
    if (lessons.isEmpty) {
      return const Center(
        child: BodyTitle(
          text: 'No lessons available.',
          fontSize: 13,
          color: AppColors.searchRatingText,
        ),
      );
    }
    return ListView.separated(
      key: const PageStorageKey('lessons-tab-scroll'),
      padding: EdgeInsets.fromLTRB(
        AppPaddingWidth.p18,
        0,
        AppPaddingWidth.p18,
        AppPaddingHeight.p90,
      ),
      itemCount: lessons.length,
      separatorBuilder: (_, _) =>
          const Divider(height: 1, color: AppColors.searchCardBorder),
      itemBuilder: (context, index) {
        final lesson = lessons[index];
        return ListTile(
          leading: const Icon(
            Icons.play_circle_fill,
            size: 20,
            color: AppColors.primary,
          ),
          title: BodyTitle(
            text: lesson.title,
            fontSize: 14,
            color: AppColors.searchCardTitle,
          ),
          subtitle: lesson.durationEstimateSeconds == null
              ? null
              : BodyTitle(
                  text: _duration(lesson.durationEstimateSeconds!),
                  fontSize: 12,
                  color: AppColors.searchRatingText,
                ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showLesson(context, lesson),
        );
      },
    );
  }

  void _showLesson(BuildContext context, CourseCurriculumLessonModel lesson) {
    final description = lesson.durationEstimateSeconds == null
        ? null
        : '${lesson.durationEstimateSeconds! ~/ 60} min';
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (_) => Padding(
        padding: EdgeInsets.fromLTRB(
          AppPaddingWidth.p18,
          0,
          AppPaddingWidth.p18,
          AppPaddingHeight.p24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BodyTitle(
              text: lesson.title,
              fontSize: 18,
              color: AppColors.searchCardTitle,
            ),
            if (description?.isNotEmpty ?? false) ...[
              SizedBox(height: AppHeight.h10),
              BodyTitle(
                text: description!,
                fontSize: 13,
                color: AppColors.searchRatingText,
                overflow: TextOverflow.visible,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

String _duration(int seconds) =>
    '${seconds ~/ 60}:${(seconds % 60).toString().padLeft(2, '0')}';
