import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/teachers/widgets/teacher_data.dart';
import 'package:wlcd/presentation/screens/teachers/widgets/teacher_profile_widgets.dart';

class TeacherProfileScreen extends StatelessWidget {
  const TeacherProfileScreen({super.key, required this.teacher});

  final TeacherData teacher;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.teacherBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: AppHeight.h260,
            backgroundColor: AppColors.white,
            surfaceTintColor: AppColors.white,
            flexibleSpace: FlexibleSpaceBar(background: TeacherProfileHero(teacher: teacher)),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              AppPaddingWidth.p20,
              AppPaddingHeight.p20,
              AppPaddingWidth.p20,
              AppPaddingHeight.p40,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                TeacherProfileStats(teacher: teacher),
                SizedBox(height: AppHeight.h20),
                TeacherProfileActions(teacher: teacher),
                SizedBox(height: AppHeight.h24),
                const TeacherProfileTabs(),
                SizedBox(height: AppHeight.h28),
                TeacherAboutCard(teacher: teacher),
                SizedBox(height: AppHeight.h20),
                TeacherCoursesCard(teacher: teacher),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
