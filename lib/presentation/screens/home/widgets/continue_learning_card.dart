import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class ContinueLearningCard extends StatelessWidget {
  const ContinueLearningCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [BoxShadow(color: AppColors.greySec, spreadRadius: -1, blurRadius: 4, offset: Offset(0, 3))],
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.r12),
      ),
      height: AppHeight.h140,
      width: AppWidth.w400,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(AppPaddingWidth.p13),
            child: const ContinueLearningTopRow(),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(AppPaddingWidth.p13, 0, AppPaddingWidth.p13, AppPaddingHeight.p7),
            child: const ContinueLearningStatsRow(),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0, left: AppPaddingWidth.p10, right: AppPaddingWidth.p10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.r7),
              child: LinearProgressIndicator(
                minHeight: AppHeight.h10,
                value: .75,
                backgroundColor: AppColors.progressTrack,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContinueLearningTopRow extends StatelessWidget {
  const ContinueLearningTopRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ContinueCourseThumb(),
        SizedBox(width: AppWidth.w14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BodyTitle(
                text: 'Website',
                color: AppColors.warning,
                fontSize: AppFontSize.s10,
                fontWeight: AppFontWeight.extraBold,
              ),
              SizedBox(height: AppHeight.h5),
              SectionTitle(
                text: 'Fundamentals of HTML & CSS From Scratch',
                color: AppColors.text,
                fontSize: AppFontSize.s13,
                fontWeight: AppFontWeight.extraBold,
                height: 1.32,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ContinueLearningStatsRow extends StatelessWidget {
  const ContinueLearningStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        ProgressText(text: '24 of 33 Lessons'),
        ProgressText(text: '75% completed'),
      ],
    );
  }
}

class ContinueCourseThumb extends StatelessWidget {
  const ContinueCourseThumb({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppWidth.w80,
      height: AppHeight.h60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.r4),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF9FB6C9), Color(0xFFEEF3F7), Color(0xFF885A47), Color(0xFF3F2F2D)],
          stops: [0, .42, .43, 1],
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(child: Container(color: const Color(0x33141C41))),
          PositionedDirectional(
            top: AppHeight.h7,
            start: AppWidth.w7,
            end: AppWidth.w7,
            bottom: AppHeight.h7,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.r2),
                border: Border.all(color: AppColors.white.withOpacity(.65), width: AppWidth.w1),
              ),
            ),
          ),
          PositionedDirectional(
            start: AppWidth.w16,
            bottom: AppHeight.h11,
            child: Container(
              width: AppWidth.w40,
              height: AppHeight.h5,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(.8),
                borderRadius: BorderRadius.circular(AppRadius.r4),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.white.withOpacity(.45),
                    offset: Offset(0, -AppHeight.h10),
                    spreadRadius: AppHeight.h1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressText extends StatelessWidget {
  const ProgressText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return BodyTitle(text: text, color: AppColors.muted, fontSize: AppFontSize.s10, fontWeight: AppFontWeight.bold);
  }
}
