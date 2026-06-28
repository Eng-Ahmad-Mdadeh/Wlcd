import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/teachers/widgets/teacher_card.dart';
import 'package:wlcd/presentation/screens/teachers/widgets/teacher_data.dart';

class TeachersList extends StatelessWidget {
  const TeachersList({super.key, required this.teachers});

  final List<TeacherData> teachers;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            AppPaddingWidth.p20,
            AppPaddingHeight.p10,
            AppPaddingWidth.p20,
            AppPaddingHeight.p30,
          ),
          sliver: SliverList.separated(
            itemCount: teachers.length,
            separatorBuilder: (_, __) => SizedBox(height: AppHeight.h16),
            itemBuilder: (context, index) => TeacherCard(teacher: teachers[index]),
          ),
        ),
      ],
    );
  }
}
