import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class DownloadedTab extends StatelessWidget {
  const DownloadedTab({super.key});

  static const _downloadedSections = [
    _DownloadedSection(
      title: 'What is Design?',
      lessons: [
        _DownloadedLesson(title: 'Wrong Rules', duration: '03:47'),
        _DownloadedLesson(title: 'Summary', duration: '02:28'),
      ],
    ),
    _DownloadedSection(
      title: 'Design Process',
      lessons: [
        _DownloadedLesson(title: 'Design Process', duration: '03:47'),
        _DownloadedLesson(title: 'Process Problem', duration: '04:44', isDisabled: true),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      key: const PageStorageKey('downloaded-tab-scroll'),
      padding: EdgeInsets.fromLTRB(AppPaddingWidth.p18, 0, AppPaddingWidth.p18, AppPaddingHeight.p90),
      itemCount: _downloadedSections.length,
      separatorBuilder: (_, __) => SizedBox(height: AppHeight.h18),
      itemBuilder: (context, sectionIndex) {
        final section = _downloadedSections[sectionIndex];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(text: section.title, fontSize: 14, color: AppColors.searchCardTitle),
            SizedBox(height: AppHeight.h12),
            ListView.separated(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: section.lessons.length,
              separatorBuilder: (_, __) => SizedBox(height: AppHeight.h14),
              itemBuilder: (context, lessonIndex) {
                return _DownloadedLessonTile(lesson: section.lessons[lessonIndex]);
              },
            ),
          ],
        );
      },
    );
  }
}

class _DownloadedLessonTile extends StatelessWidget {
  const _DownloadedLessonTile({required this.lesson});

  final _DownloadedLesson lesson;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = lesson.isDisabled ? AppColors.navInactive : AppColors.searchCardTitle;
    final secondaryColor = lesson.isDisabled ? AppColors.lightGreySec : AppColors.searchRatingText;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p12, vertical: AppPaddingHeight.p11),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.searchCardBorder),
        borderRadius: BorderRadius.circular(AppRadius.r12),
      ),
      child: Row(
        children: [
          Container(
            height: AppHeight.h18,
            width: AppWidth.w18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.progressTrack.withValues(alpha: lesson.isDisabled ? .45 : 1),
            ),
            child: Icon(
              Icons.play_arrow_rounded,
              size: 14,
              color: lesson.isDisabled ? AppColors.navInactive : AppColors.primary,
            ),
          ),
          SizedBox(width: AppWidth.w10),
          Expanded(child: BodyTitle(text: lesson.title, fontSize: 14, color: foregroundColor)),
          BodyTitle(text: lesson.duration, fontSize: 13, color: secondaryColor),
          SizedBox(width: AppWidth.w10),
          Icon(
            Icons.delete_outline_rounded,
            size: 20,
            color: lesson.isDisabled ? AppColors.navInactive : AppColors.primary,
          ),
        ],
      ),
    );
  }
}

class _DownloadedSection {
  const _DownloadedSection({required this.title, required this.lessons});

  final String title;
  final List<_DownloadedLesson> lessons;
}

class _DownloadedLesson {
  const _DownloadedLesson({required this.title, required this.duration, this.isDisabled = false});

  final String title;
  final String duration;
  final bool isDisabled;
}
