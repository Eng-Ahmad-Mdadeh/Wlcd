import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/core/routes/app_routes.dart';
import 'package:wlcd/presentation/screens/teachers/widgets/rating_badge.dart';
import 'package:wlcd/presentation/screens/teachers/widgets/specialty_chip.dart';
import 'package:wlcd/data/model/instructor/instructor_model.dart';
import 'package:wlcd/presentation/screens/teachers/widgets/teacher_photo.dart';

class TeacherCard extends StatelessWidget {
  const TeacherCard({super.key, required this.teacher});

  final InstructorModel teacher;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.r27),
      onTap: () => TeacherProfileRoute(id: teacher.instructorId!).push(context),
      child: Container(
        padding: EdgeInsets.all(AppSize.s14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.r27),
          border: Border.all(color: AppColors.teacherCardBorder),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackCow.withValues(alpha: .08),
              blurRadius: AppSize.s24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TeacherPhoto(teacher: teacher),
            SizedBox(width: AppWidth.w14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          teacher.displayName ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.text,
                            fontSize: AppSize.s17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      RatingBadge(rating: teacher.rating ?? 0),
                    ],
                  ),
                  SizedBox(height: AppHeight.h8),
                  SpecialtyChip(
                    label: teacher.specialty?.title ?? '',
                    color: AppColors.teacherPurple,
                  ),
                  SizedBox(height: AppHeight.h10),
                  Text(
                    teacher.biography ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.muted,
                      fontSize: AppSize.s13,
                      height: AppLineHeight.teacherBio,
                    ),
                  ),
                  SizedBox(height: AppHeight.h12),
                  Row(
                    children: [
                      Icon(Icons.groups_rounded, size: AppSize.s16, color: AppColors.accent),
                      SizedBox(width: AppWidth.w5),
                      Text(
                        '${teacher.studentsCount ?? 0} طالب',
                        style: TextStyle(
                          color: AppColors.seeMore,
                          fontSize: AppSize.s12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
