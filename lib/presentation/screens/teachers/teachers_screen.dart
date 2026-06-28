import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/presentation/screens/teachers/widgets/teacher_data.dart';
import 'package:wlcd/presentation/screens/teachers/widgets/teachers_list.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';

class TeachersScreen extends StatelessWidget {
  const TeachersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.teacherBackground,
      appBar: CustomAppBar(
        title: 'المدرسون',
        centerTitle: true,
        backgroundColor: AppColors.primary,
        colorTitle: AppColors.white,
      ),
      body: const TeachersList(teachers: teachers),
    );
  }
}
