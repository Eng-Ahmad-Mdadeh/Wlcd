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
        return _DownloadedSectionView(section: _downloadedSections[sectionIndex]);
      },
    );
  }
}

class _DownloadedSectionView extends StatelessWidget {
  const _DownloadedSectionView({required this.section});

  final _DownloadedSection section;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(text: section.title, fontSize: 14, color: AppColors.searchCardTitle),
        SizedBox(height: AppHeight.h12),
        for (final (index, lesson) in section.lessons.indexed) ...[
          _DownloadedLessonTile(lesson: lesson),
          if (index != section.lessons.length - 1) SizedBox(height: AppHeight.h14),
        ],
      ],
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

    return Material(
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColors.searchCardBorder),
        borderRadius: BorderRadius.circular(AppRadius.r12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.r12),
        onTap: lesson.isDisabled ? null : () {},
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p12, vertical: AppPaddingHeight.p11),
          child: Row(
            children: [
              _PlayIndicator(isDisabled: lesson.isDisabled),
              SizedBox(width: AppWidth.w10),
              Expanded(child: BodyTitle(text: lesson.title, fontSize: 14, color: foregroundColor)),
              BodyTitle(text: lesson.duration, fontSize: 13, color: secondaryColor),
              SizedBox(width: AppWidth.w10),
              IconButton(
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints.tightFor(width: 24, height: 24),
                onPressed: lesson.isDisabled ? null : () {},
                icon: Icon(
                  Icons.delete_outline_rounded,
                  size: 20,
                  color: lesson.isDisabled ? AppColors.navInactive : AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlayIndicator extends StatelessWidget {
  const _PlayIndicator({required this.isDisabled});

  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppHeight.h18,
      width: AppWidth.w18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.progressTrack.withValues(alpha: isDisabled ? .45 : 1),
      ),
      child: Icon(
        Icons.play_arrow_rounded,
        size: 14,
        color: isDisabled ? AppColors.navInactive : AppColors.primary,
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
