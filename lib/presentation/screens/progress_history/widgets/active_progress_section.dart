import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/progress_history/widgets/progress_course_card.dart';
import 'package:wlcd/presentation/screens/progress_history/widgets/progress_history_data.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class ActiveProgressSection extends StatelessWidget {
  const ActiveProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          text: 'التقدم النشط',
          color: AppColors.text,
          fontSize: AppFontSize.s16,
          fontWeight: AppFontWeight.extraBold,
        ),
        SizedBox(height: AppHeight.h17),
        ...activeProgressCourses.map(
          (course) => Padding(
            padding: EdgeInsets.only(bottom: AppHeight.h17),
            child: ProgressCourseCard(course: course),
          ),
        ),
      ],
    );
  }
}
