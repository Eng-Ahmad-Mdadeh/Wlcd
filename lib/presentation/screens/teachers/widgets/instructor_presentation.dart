import 'package:flutter/material.dart';
import 'package:wlcd/core/constants/api_endpoints.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/data/model/instructor/instructor_model.dart';

extension InstructorPresentation on InstructorModel {
  String get name => displayName ?? '';
  String get specialtyName => specialty?.title ?? '';
  String get bio => biography ?? '';
  String get students => (studentsCount ?? 0).toString();
  double get ratingValue => rating ?? 0;

  String get imageUrl {
    final id = mediaId;
    if (id == null || id.isEmpty) return '';
    return '${ApiEndpoints.baseUrl.replaceFirst('/api/v1', '')}/media/public/$id';
  }

  Color get accentColor {
    const colors = [
      AppColors.teacherPurple,
      AppColors.teacherCyan,
      AppColors.teacherAmber,
      AppColors.teacherGreen,
    ];
    return colors[(instructorId ?? '').hashCode.abs() % colors.length];
  }
}
