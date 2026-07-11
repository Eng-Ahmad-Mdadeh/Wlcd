import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/teachers/widgets/teacher_booking_sheet.dart';
import 'package:wlcd/presentation/screens/teachers/widgets/teacher_data.dart';
import 'package:wlcd/presentation/widgets/custom_bottom_sheet.dart';
import 'package:wlcd/presentation/widgets/image_view.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class TeacherProfileHero extends StatelessWidget {
  const TeacherProfileHero({super.key, required this.teacher});

  final TeacherData teacher;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(AppPaddingWidth.p20, 0, AppPaddingWidth.p20, AppPaddingHeight.p24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [teacher.accentColor.withValues(alpha: .18), AppColors.white, AppColors.white],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(AppSize.s5),
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: teacher.accentColor.withValues(alpha: .22),
                  blurRadius: 30,
                  offset: const Offset(0, 14),
                ),
              ],
            ),
            child: ClipOval(
              child: ImageView(
                imagePath: teacher.imageUrl,
                width: AppWidth.w110,
                height: AppHeight.h110,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: AppHeight.h14),
          SectionTitle(
            text: teacher.name,
            color: AppColors.text,
            fontSize: AppFontSize.s24,
            fontWeight: AppFontWeight.extraBold,
          ),
          SizedBox(height: AppHeight.h6),
          BodyTitle(
            text: teacher.specialty,
            color: teacher.accentColor,
            fontSize: AppFontSize.s14,
            fontWeight: AppFontWeight.extraBold,
          ),
          SizedBox(height: AppHeight.h12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TeacherSocialButton(icon: Icons.link_rounded),
              TeacherSocialButton(icon: Icons.camera_alt_outlined),
              TeacherSocialButton(icon: Icons.business_center_outlined),
              TeacherSocialButton(icon: Icons.more_horiz_rounded),
            ],
          ),
        ],
      ),
    );
  }
}

class TeacherSocialButton extends StatelessWidget {
  const TeacherSocialButton({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppWidth.w40,
      height: AppHeight.h40,
      margin: EdgeInsets.symmetric(horizontal: AppMarginWidth.m5),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.r14),
        border: Border.all(color: AppColors.teacherCardBorder),
      ),
      child: Icon(icon, color: AppColors.teacherPurple, size: AppSize.s22),
    );
  }
}

class TeacherProfileStats extends StatelessWidget {
  const TeacherProfileStats({super.key, required this.teacher});

  final TeacherData teacher;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TeacherStatCard(
            value: teacher.students,
            label: 'طالب',
            icon: Icons.groups_rounded,
            color: teacher.accentColor,
          ),
        ),
        SizedBox(width: AppWidth.w12),
        Expanded(
          child: TeacherStatCard(
            value: teacher.rating.toStringAsFixed(1),
            label: 'تقييم',
            icon: Icons.star_rounded,
            color: AppColors.teacherAmber,
          ),
        ),
        SizedBox(width: AppWidth.w12),
        const Expanded(
          child: TeacherStatCard(
            value: '12',
            label: 'دورة',
            icon: Icons.play_lesson_rounded,
            color: AppColors.teacherGreen,
          ),
        ),
      ],
    );
  }
}

class TeacherStatCard extends StatelessWidget {
  const TeacherStatCard({super.key, required this.value, required this.label, required this.icon, required this.color});

  final String value;
  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppPaddingHeight.p14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.r22),
        border: Border.all(color: AppColors.teacherCardBorder),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: AppSize.s22),
          SizedBox(height: AppHeight.h6),
          SectionTitle(
            text: value,
            color: AppColors.text,
            fontSize: AppFontSize.s17,
            fontWeight: AppFontWeight.extraBold,
          ),
          SizedBox(height: AppHeight.h2),
          BodyTitle(text: label, color: AppColors.muted, fontSize: AppFontSize.s12, fontWeight: AppFontWeight.semiBold),
        ],
      ),
    );
  }
}

class TeacherProfileActions extends StatelessWidget {
  const TeacherProfileActions({super.key, required this.teacher});

  final TeacherData teacher;

  @override
  Widget build(BuildContext context) {
    return TeacherActionButton(
      label: 'احجز حصة',
      icon: Icons.calendar_month_rounded,
      color: AppColors.teacherGreen,
      onTap: () => _showBooking(context),
    );
  }

  void _showBooking(BuildContext context) {
    CustomBottomSheet.show(
      context,
      title: 'حجز جلسة',
      heightFactor: .75,
      borderRadius: AppRadius.r30,
      body: TeacherBookingSheet(teacher: teacher),
    );
  }
}

class TeacherActionButton extends StatelessWidget {
  const TeacherActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.r24),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: AppPaddingHeight.p16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppRadius.r24),
          boxShadow: [BoxShadow(color: color.withValues(alpha: .22), blurRadius: 18, offset: const Offset(0, 10))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.white, size: AppSize.s24),
            SizedBox(width: AppWidth.w10),
            SectionTitle(
              text: label,
              color: AppColors.white,
              fontSize: AppFontSize.s18,
              fontWeight: AppFontWeight.extraBold,
            ),
          ],
        ),
      ),
    );
  }
}



class TeacherTabChip extends StatelessWidget {
  const TeacherTabChip({super.key, required this.label, required this.selected});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: AppPaddingHeight.p13),
      decoration: BoxDecoration(
        color: selected ? AppColors.seeMore : AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.r24),
        border: Border.all(color: selected ? AppColors.seeMore : AppColors.teacherCardBorder),
      ),
      child: BodyTitle(
        text: label,
        textAlign: TextAlign.center,
        color: selected ? AppColors.white : AppColors.text,
        fontSize: AppFontSize.s13,
        fontWeight: AppFontWeight.extraBold,
      ),
    );
  }
}

class TeacherAboutCard extends StatelessWidget {
  const TeacherAboutCard({super.key, required this.teacher});

  final TeacherData teacher;

  @override
  Widget build(BuildContext context) {
    return TeacherSectionCard(
      title: 'نبذة عني',
      icon: Icons.person_outline_rounded,
      child: BodyTitle(
        text:
            '${teacher.bio}\n\nأقدم تجربة تعليمية عملية تساعد المتعلمين على تحويل المعرفة إلى خطوات قابلة للتطبيق، مع تبسيط المفاهيم وبناء خطة واضحة للتطور المهني.',
        textAlign: TextAlign.right,
        color: AppColors.muted,
        fontSize: AppFontSize.s15,
        fontWeight: AppFontWeight.medium,
        height: 1.8,
        maxLines: 8,
      ),
    );
  }
}

class TeacherCoursesCard extends StatelessWidget {
  const TeacherCoursesCard({super.key, required this.teacher});

  final TeacherData teacher;

  @override
  Widget build(BuildContext context) {
    return TeacherSectionCard(
      title: 'دوراتي',
      icon: Icons.menu_book_outlined,
      child: Column(
        children: [
          TeacherCourseTile(
            color: teacher.accentColor,
            title: 'رحلة التعلم معي',
            subtitle: 'مسار تطبيقي يبدأ من الأساسيات حتى بناء مشروع عملي.',
          ),
          SizedBox(height: AppHeight.h12),
          TeacherCourseTile(
            color: AppColors.teacherGreen,
            title: teacher.specialty,
            subtitle: 'دروس قصيرة، تمارين، ومتابعة تساعدك على تحقيق نتائج واضحة.',
          ),
        ],
      ),
    );
  }
}

class TeacherSectionCard extends StatelessWidget {
  const TeacherSectionCard({super.key, required this.title, required this.icon, required this.child});

  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSize.s18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.r28),
        border: Border.all(color: AppColors.teacherCardBorder),
        boxShadow: [
          BoxShadow(color: AppColors.blackCow.withValues(alpha: .05), blurRadius: 24, offset: const Offset(0, 12)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SectionTitle(
                text: title,
                color: AppColors.text,
                fontSize: AppFontSize.s20,
                fontWeight: AppFontWeight.extraBold,
              ),
              SizedBox(width: AppWidth.w10),
              Icon(icon, color: AppColors.seeMore, size: AppSize.s24),
            ],
          ),
          SizedBox(height: AppHeight.h16),
          child,
        ],
      ),
    );
  }
}

class TeacherCourseTile extends StatelessWidget {
  const TeacherCourseTile({super.key, required this.color, required this.title, required this.subtitle});

  final Color color;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSize.s12),
      decoration: BoxDecoration(
        color: AppColors.teacherBackground,
        borderRadius: BorderRadius.circular(AppRadius.r20),
        border: Border.all(color: AppColors.teacherCardBorder),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Container(
            width: AppWidth.w70,
            height: AppHeight.h70,
            decoration: BoxDecoration(
              color: color.withValues(alpha: .14),
              borderRadius: BorderRadius.circular(AppRadius.r18),
            ),
            child: Icon(Icons.school_rounded, color: color, size: AppSize.s30),
          ),
          SizedBox(width: AppWidth.w12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SectionTitle(
                  text: title,
                  textAlign: TextAlign.right,
                  color: AppColors.text,
                  fontSize: AppFontSize.s16,
                  maxLines: 1,
                ),
                SizedBox(height: AppHeight.h6),
                BodyTitle(
                  text: subtitle,
                  textAlign: TextAlign.right,
                  color: AppColors.muted,
                  fontSize: AppFontSize.s12,
                  fontWeight: AppFontWeight.semiBold,
                  height: 1.45,
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
