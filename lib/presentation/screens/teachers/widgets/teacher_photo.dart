import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/teachers/widgets/teacher_data.dart';
import 'package:wlcd/presentation/widgets/image_view.dart';

class TeacherPhoto extends StatelessWidget {
  const TeacherPhoto({super.key, required this.teacher});

  final TeacherData teacher;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppWidth.w89,
      height: AppHeight.h113,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.r22),
        gradient: LinearGradient(
          colors: [
            teacher.accentColor.withValues(alpha: .22),
            teacher.accentColor.withValues(alpha: .06),
          ],
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: ImageView(imagePath: teacher.imageUrl, fit: BoxFit.cover),
    );
  }
}
