import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/progress_history/widgets/watching_time_chart.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class WatchingTimeSection extends StatelessWidget {
  const WatchingTimeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SectionTitle(
              text: 'وقت المشاهدة',
              color: AppColors.text,
              fontSize: AppFontSize.s16,
              fontWeight: AppFontWeight.extraBold,
            ),
            const _DateRangeChip(),
          ],
        ),
        SizedBox(height: AppHeight.h25),
        const WatchingTimeChart(),
      ],
    );
  }
}

class _DateRangeChip extends StatelessWidget {
  const _DateRangeChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p10, vertical: AppPaddingHeight.p7),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.notificationBorder),
        borderRadius: BorderRadius.circular(AppRadius.r8),
      ),
      child: Row(
        children: [
          BodyTitle(
            text: 'آخر 7 أيام',
            color: AppColors.muted,
            fontSize: AppFontSize.s10,
            fontWeight: AppFontWeight.bold,
          ),
          SizedBox(width: AppWidth.w4),
          Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.muted, size: AppSize.s15),
        ],
      ),
    );
  }
}
