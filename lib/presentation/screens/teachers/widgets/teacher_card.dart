import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/presentation/screens/teachers/widgets/rating_badge.dart';
import 'package:wlcd/presentation/screens/teachers/widgets/specialty_chip.dart';
import 'package:wlcd/presentation/screens/teachers/widgets/teacher_data.dart';
import 'package:wlcd/presentation/screens/teachers/widgets/teacher_photo.dart';

class TeacherCard extends StatelessWidget {
  const TeacherCard({super.key, required this.teacher});

  final TeacherData teacher;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(26.r),
        border: Border.all(color: const Color(0xFFECEEF5)),
        boxShadow: [
          BoxShadow(color: AppColors.primary.withValues(alpha: .08), blurRadius: 24, offset: const Offset(0, 12)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TeacherPhoto(teacher: teacher),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        teacher.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: AppColors.text, fontSize: 17.sp, fontWeight: FontWeight.w800),
                      ),
                    ),
                    RatingBadge(rating: teacher.rating),
                  ],
                ),
                SizedBox(height: 8.h),
                SpecialtyChip(label: teacher.specialty, color: teacher.accentColor),
                SizedBox(height: 10.h),
                Text(
                  teacher.bio,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppColors.muted, fontSize: 12.5.sp, height: 1.55),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Icon(Icons.groups_rounded, size: 16.r, color: AppColors.accent),
                    SizedBox(width: 5.w),
                    Text(
                      '${teacher.students} طالب',
                      style: TextStyle(color: AppColors.seeMore, fontSize: 12.sp, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
