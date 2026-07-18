import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart' show Iconsax;
import 'package:share_plus/share_plus.dart' show ShareParams, SharePlus;
import 'package:wlcd/core/extension/localization_extension.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/teachers/widgets/teacher_data.dart';
import 'package:wlcd/presentation/screens/teachers/teacher_profile/widgets/teacher_profile_widgets.dart';

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
            expandedHeight: AppHeight.h300,
            actionsPadding: EdgeInsets.zero,
            backgroundColor: AppColors.white,
            actions: [
              InkWell(
                onTap: () async {
                  final box = context.findRenderObject() as RenderBox?;
                  await SharePlus.instance.share(
                    ShareParams(
                      text: "شارك ملف المعلم الشخصي",
                      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsetsDirectional.only(end: AppPaddingWidth.p15),
                  child: Icon(Iconsax.share_outline),
                ),
              ),
            ],
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
