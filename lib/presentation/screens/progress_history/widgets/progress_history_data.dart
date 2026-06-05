import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';

class WatchingTimeDayData {
  const WatchingTimeDayData(this.label, this.minutes, {this.isSelected = false});

  final String label;
  final int minutes;
  final bool isSelected;
}

class ProgressCourseData {
  const ProgressCourseData({
    required this.category,
    required this.categoryColor,
    required this.title,
    required this.lessonsText,
    required this.progressText,
    required this.progress,
    required this.thumbType,
  });

  final String category;
  final Color categoryColor;
  final String title;
  final String lessonsText;
  final String progressText;
  final double progress;
  final ProgressThumbType thumbType;
}

enum ProgressThumbType { website, finance }

const List<WatchingTimeDayData> watchingTimeDays = [
  WatchingTimeDayData('الأحد', 24),
  WatchingTimeDayData('الإثنين', 55),
  WatchingTimeDayData('الثلاثاء', 68),
  WatchingTimeDayData('الأربعاء', 48),
  WatchingTimeDayData('الخميس', 75, isSelected: true),
  WatchingTimeDayData('الجمعة', 62),
  WatchingTimeDayData('السبت', 25),
];

const List<ProgressCourseData> activeProgressCourses = [
  ProgressCourseData(
    category: 'تطوير الويب',
    categoryColor: AppColors.warning,
    title: 'أساسيات HTML و CSS من الصفر',
    lessonsText: '24 من 33 درساً',
    progressText: '75% مكتمل',
    progress: .75,
    thumbType: ProgressThumbType.website,
  ),
  ProgressCourseData(
    category: 'إدارة مالية',
    categoryColor: AppColors.notificationDot,
    title: 'برنامج قيادة المدير المالي',
    lessonsText: '10 من 25 درساً',
    progressText: '40% مكتمل',
    progress: .40,
    thumbType: ProgressThumbType.finance,
  ),
];
