import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/progress_history/widgets/progress_history_data.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';

class WatchingTimeChart extends StatelessWidget {
  const WatchingTimeChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppHeight.h170,
      child: Stack(
        children: [
          PositionedDirectional(
            start: 0,
            end: 0,
            top: AppHeight.h62,
            child: const _DashedDivider(),
          ),
          Positioned.fill(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: watchingTimeDays.map((day) => _ChartDayColumn(data: day)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartDayColumn extends StatelessWidget {
  const _ChartDayColumn({required this.data});

  final WatchingTimeDayData data;

  @override
  Widget build(BuildContext context) {
    final barHeight = math.max(AppHeight.h35, AppHeight.h115 * data.minutes / 90);
    final barColor = data.isSelected ? AppColors.primary : AppColors.progressTrack;
    final labelColor = data.isSelected ? AppColors.white : AppColors.text;

    return SizedBox(
      width: AppWidth.w45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (data.isSelected) ...[
            BodyTitle(
              text: '${data.minutes} دقيقة',
              color: AppColors.text,
              fontSize: AppFontSize.s10,
              fontWeight: AppFontWeight.bold,
            ),
            SizedBox(height: AppHeight.h5),
          ],
          Container(
            width: AppWidth.w45,
            height: barHeight,
            padding: EdgeInsetsDirectional.only(bottom: AppPaddingHeight.p10),
            decoration: BoxDecoration(color: barColor, borderRadius: BorderRadius.circular(AppRadius.r20)),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: BodyTitle(
                text: data.label,
                color: labelColor,
                fontSize: AppFontSize.s7,
                fontWeight: AppFontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedDivider extends StatelessWidget {
  const _DashedDivider();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppHeight.h1,
      child: CustomPaint(painter: _DashedDividerPainter()),
    );
  }
}

class _DashedDividerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withOpacity(.55)
      ..strokeWidth = 1;
    const dashWidth = 7.0;
    const dashGap = 5.0;
    var startX = 0.0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(math.min(startX + dashWidth, size.width), 0), paint);
      startX += dashWidth + dashGap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
