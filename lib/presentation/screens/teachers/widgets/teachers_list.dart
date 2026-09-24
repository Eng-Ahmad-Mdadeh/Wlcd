import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/teachers/widgets/teacher_card.dart';
import 'package:wlcd/data/model/instructor/instructor_model.dart';

class TeachersList extends StatelessWidget {
  const TeachersList({super.key, required this.teachers});

  final List<InstructorModel> teachers;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            AppPaddingWidth.p13,
            AppPaddingHeight.p10,
            AppPaddingWidth.p13,
            AppPaddingHeight.p30,
          ),
          sliver: SliverList.separated(
            itemCount: teachers.length,
            separatorBuilder: (_, __) => SizedBox(height: AppHeight.h13),
            itemBuilder: (context, index) => TeacherCard(teacher: teachers[index]),
          ),
        ),
      ],
    );
  }
}
