import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/progress_history/widgets/progress_course_thumb.dart';
import 'package:wlcd/presentation/screens/progress_history/widgets/progress_history_data.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class ProgressCourseCard extends StatelessWidget {
  const ProgressCourseCard({super.key, required this.course});

  final ProgressCourseData course;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPaddingWidth.p13),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.r14),
        border: Border.all(color: AppColors.notificationBorder),
        boxShadow: const [BoxShadow(color: AppColors.greySec, spreadRadius: -2, blurRadius: 8, offset: Offset(0, 4))],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProgressCourseThumb(type: course.thumbType),
              SizedBox(width: AppWidth.w14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BodyTitle(
                      text: course.category,
                      color: course.categoryColor,
                      fontSize: AppFontSize.s10,
                      fontWeight: AppFontWeight.extraBold,
                    ),
                    SizedBox(height: AppHeight.h7),
                    SectionTitle(
                      text: course.title,
                      color: AppColors.text,
                      fontSize: AppFontSize.s13,
                      fontWeight: AppFontWeight.extraBold,
                      height: 1.35,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppHeight.h12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ProgressMetaText(text: course.lessonsText),
              _ProgressMetaText(text: course.progressText),
            ],
          ),
          SizedBox(height: AppHeight.h10),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.r7),
            child: LinearProgressIndicator(
              minHeight: AppHeight.h8,
              value: course.progress,
              backgroundColor: AppColors.progressTrack,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressMetaText extends StatelessWidget {
  const _ProgressMetaText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return BodyTitle(text: text, color: AppColors.muted, fontSize: AppFontSize.s11, fontWeight: AppFontWeight.bold);
  }
}
