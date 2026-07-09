import 'package:flutter/material.dart';
import 'package:wlcd/core/extension/localization_extension.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/image_view.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class ExternalCoursesSection extends StatelessWidget {
  const ExternalCoursesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final courses = [
      ExternalCourseData(
        platform: context.loc.home_external_course_platform_coursera,
        title: context.loc.home_external_course_title_coursera,
        description: context.loc.home_external_course_description_coursera,
        imageUrl:
            'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?auto=format&fit=crop&w=900&q=80',
      ),
      ExternalCourseData(
        platform: context.loc.home_external_course_platform_google,
        title: context.loc.home_external_course_title_google,
        description: context.loc.home_external_course_description_google,
        imageUrl:
            'https://images.unsplash.com/photo-1497366754035-f200968a6e72?auto=format&fit=crop&w=900&q=80',
      ),
    ];

    return SizedBox(
      height: AppHeight.h190,
      child: ListView.separated(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: courses.length,
        separatorBuilder: (_, __) => SizedBox(width: AppWidth.w14),
        itemBuilder: (context, index) => ExternalCourseCard(course: courses[index]),
      ),
    );
  }
}

class ExternalCourseCard extends StatelessWidget {
  const ExternalCourseCard({super.key, required this.course});

  final ExternalCourseData course;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppWidth.w280,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.r18),
        border: Border.all(color: AppColors.searchCardBorder),
        boxShadow: const [BoxShadow(color: AppColors.greySec, spreadRadius: -1, blurRadius: 8, offset: Offset(0, 4))],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ImageView(imagePath: course.imageUrl, width: double.infinity, height: AppHeight.h100, fit: BoxFit.cover),
              PositionedDirectional(
                top: AppHeight.h10,
                start: AppWidth.w10,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p10, vertical: AppPaddingHeight.p5),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(.88),
                    borderRadius: BorderRadius.circular(AppRadius.r20),
                  ),
                  child: BodyTitle(
                    text: course.platform,
                    color: AppColors.white,
                    fontSize: AppFontSize.s10,
                    fontWeight: AppFontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(AppPaddingWidth.p12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(
                  text: course.title,
                  color: AppColors.text,
                  fontSize: AppFontSize.s13,
                  fontWeight: AppFontWeight.extraBold,
                  maxLines: 1,
                ),
                SizedBox(height: AppHeight.h8),
                BodyTitle(
                  text: course.description,
                  color: AppColors.muted,
                  fontSize: AppFontSize.s11,
                  fontWeight: AppFontWeight.semiBold,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ExternalCourseData {
  const ExternalCourseData({required this.platform, required this.title, required this.description, required this.imageUrl});

  final String platform;
  final String title;
  final String description;
  final String imageUrl;
}
