import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/core/routes/app_routes.dart';
import 'package:wlcd/presentation/screens/teachers/widgets/teacher_data.dart';
import 'package:wlcd/presentation/screens/teachers/widgets/teacher_photo.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class HomeTrainersSection extends StatelessWidget {
  const HomeTrainersSection({super.key, required this.trainers});

  final List<TeacherData> trainers;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppHeight.h220,
      child: ListView.separated(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: trainers.length,
        separatorBuilder: (_, __) => SizedBox(width: AppWidth.w14),
        itemBuilder: (context, index) => HomeTrainerCard(trainer: trainers[index]),
      ),
    );
  }
}

class HomeTrainerCard extends StatelessWidget {
  const HomeTrainerCard({super.key, required this.trainer});

  final TeacherData trainer;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.r18),
      onTap: () => TeachersRoute().push(context),
      child: Container(
        width: AppWidth.w150,
        padding: EdgeInsets.all(AppPaddingWidth.p10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.r18),
          border: Border.all(color: AppColors.teacherCardBorder),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackCow.withValues(alpha: .08),
              blurRadius: AppRadius.r18,
              offset: Offset(0, AppHeight.h8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: AppWidth.w98,
                height: AppHeight.h113,
                child: TeacherPhoto(teacher: trainer),
              ),
            ),
            SizedBox(height: AppHeight.h10),
            SectionTitle(
              text: trainer.name,
              color: AppColors.text,
              fontSize: AppSize.s14,
              fontWeight: FontWeight.w800,
              maxLines: 1,
            ),
            SizedBox(height: AppHeight.h6),
            BodyTitle(
              text: trainer.specialty,
              color: trainer.accentColor,
              fontSize: AppSize.s11,
              fontWeight: FontWeight.w700,
              maxLines: 1,
            ),
            SizedBox(height: AppHeight.h8),
            Row(
              children: [
                Icon(Icons.star_rounded, size: AppSize.s15, color: AppColors.searchStar),
                SizedBox(width: AppWidth.w3),
                BodyTitle(
                  text: trainer.rating.toStringAsFixed(1),
                  color: AppColors.seeMore,
                  fontSize: AppSize.s11,
                  fontWeight: FontWeight.w700,
                ),
                const Spacer(),
                Icon(Icons.groups_rounded, size: AppSize.s14, color: AppColors.accent),
                SizedBox(width: AppWidth.w3),
                BodyTitle(
                  text: trainer.students,
                  color: AppColors.muted,
                  fontSize: AppSize.s10,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
