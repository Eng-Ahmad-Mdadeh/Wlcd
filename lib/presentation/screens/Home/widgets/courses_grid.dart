import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class CoursesGrid extends StatelessWidget {
  const CoursesGrid({super.key, required this.courses});

  final List<CourseData> courses;

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: AppPaddingHeight.p30),
        child: Center(
          child: BodyTitle(
            text: 'No courses found',
            color: AppColors.muted,
            fontSize: AppFontSize.s14,
            fontWeight: AppFontWeight.semiBold,
          ),
        ),
      );
    }

    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: courses.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppWidth.w18,
        mainAxisSpacing: AppHeight.h18,
        childAspectRatio: .75,
      ),
      itemBuilder: (context, index) => CourseCard(course: courses[index]),
    );
  }
}

class CourseCard extends StatelessWidget {
  const CourseCard({super.key, required this.course});

  final CourseData course;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [BoxShadow(color: AppColors.greySec, spreadRadius: -1, blurRadius: 4, offset: Offset(0, 3))],
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.r12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CoursePoster(type: course.posterType),
          SizedBox(height: AppHeight.h12),
          Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: AppPaddingWidth.p10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BodyTitle(
                  text: course.category,
                  color: AppColors.danger,
                  fontSize: AppFontSize.s10,
                  fontWeight: AppFontWeight.extraBold,
                ),
                SizedBox(height: AppHeight.h6),
                SectionTitle(
                  text: course.title,
                  color: AppColors.text,
                  fontSize: AppFontSize.s13,
                  height: 1.35,
                  fontWeight: AppFontWeight.extraBold,
                  maxLines: 2,
                ),
                SizedBox(height: AppHeight.h10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BodyTitle(
                      text: course.price,
                      color: AppColors.accent,
                      fontSize: AppFontSize.s13,
                      fontWeight: AppFontWeight.extraBold,
                    ),
                    BodyTitle(
                      text: course.duration,
                      color: AppColors.muted,
                      fontSize: AppFontSize.s10,
                      fontWeight: AppFontWeight.bold,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CoursePoster extends StatelessWidget {
  const CoursePoster({super.key, required this.type});

  final CoursePosterType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppHeight.h130,
      decoration: BoxDecoration(
        color: AppColors.text,
        borderRadius: BorderRadius.circular(AppRadius.r7),
        boxShadow: [
          BoxShadow(color: AppColors.text.withOpacity(.11), blurRadius: AppRadius.r18, offset: Offset(0, AppHeight.h7)),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: type == CoursePosterType.dark ? const DarkPosterArt() : const BookPosterArt(),
    );
  }
}

class DarkPosterArt extends StatelessWidget {
  const DarkPosterArt({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF030712), Color(0xFF111827), Color(0xFF0F172A)],
                stops: [0, .52, 1],
              ),
            ),
          ),
        ),
        PositionedDirectional(top: AppHeight.h35, start: AppWidth.w25, child: const CodeBadge()),
        PositionedDirectional(top: AppHeight.h32, end: AppWidth.w40, child: const PosterDot(color: Color(0xFF3B82F6))),
        PositionedDirectional(top: AppHeight.h55, start: AppWidth.w60, child: const PosterDot(color: Color(0xFFEF4444))),
      ],
    );
  }
}

class CodeBadge extends StatelessWidget {
  const CodeBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -.31,
      child: Container(
        width: AppWidth.w90,
        height: AppHeight.h54,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.r10),
          border: Border.all(color: const Color(0xFF2563EB), width: AppWidth.w1 * 2),
          boxShadow: const [BoxShadow(color: Color(0x662563EB), blurRadius: 18)],
        ),
        child: SectionTitle(text: '</>', color: AppColors.white, fontSize: AppFontSize.s18, fontWeight: AppFontWeight.extraBold),
      ),
    );
  }
}

class PosterDot extends StatelessWidget {
  const PosterDot({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(width: AppWidth.w5, height: AppHeight.h5, decoration: BoxDecoration(color: color, shape: BoxShape.circle));
  }
}

class BookPosterArt extends StatelessWidget {
  const BookPosterArt({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: const [
            Expanded(flex: 35, child: ColoredBox(color: Color(0xFFFFDE59))),
            Expanded(flex: 35, child: ColoredBox(color: Color(0xFFFF5757))),
            Expanded(flex: 30, child: ColoredBox(color: Color(0xFF2DD4BF))),
          ],
        ),
        PositionedDirectional(top: AppHeight.h18, start: AppWidth.w18, child: const BookPosterLabel(text: 'GUIDE', fontSize: 19)),
        PositionedDirectional(start: AppWidth.w18, bottom: AppHeight.h18, child: const BookPosterLabel(text: 'HTML CSS JS', fontSize: 14)),
      ],
    );
  }
}

class BookPosterLabel extends StatelessWidget {
  const BookPosterLabel({super.key, required this.text, required this.fontSize});

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p8, vertical: AppPaddingHeight.p5),
      decoration: BoxDecoration(color: AppColors.white.withOpacity(.88), borderRadius: BorderRadius.circular(AppRadius.r4)),
      child: SectionTitle(text: text, color: AppColors.text, fontSize: fontSize, fontWeight: AppFontWeight.extraBold, height: 1.3),
    );
  }
}

class CourseData {
  const CourseData({required this.category, required this.title, required this.price, required this.duration, required this.posterType});

  final String category;
  final String title;
  final String price;
  final String duration;
  final CoursePosterType posterType;
}

enum CoursePosterType { dark, book }
