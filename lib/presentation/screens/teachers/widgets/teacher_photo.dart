import 'package:flutter/material.dart';
import 'package:wlcd/core/constants/api_endpoints.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/data/model/instructor/instructor_model.dart';
import 'package:wlcd/presentation/widgets/image_view.dart';

class TeacherPhoto extends StatelessWidget {
  const TeacherPhoto({super.key, required this.teacher});

  final InstructorModel teacher;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppWidth.w89,
      height: AppHeight.h113,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.r22),
        gradient: LinearGradient(
          colors: [
            AppColors.teacherPurple.withValues(alpha: .22),
            AppColors.teacherPurple.withValues(alpha: .06),
          ],
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: ImageView(
        imagePath: ApiEndpoints.publicMedia(teacher.mediaId ?? ''),
        fit: BoxFit.cover,
      ),
    );
  }
}
