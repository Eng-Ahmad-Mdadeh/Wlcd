import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/teachers/widgets/teacher_booking_sheet.dart';
import 'package:wlcd/presentation/screens/teachers/widgets/teacher_data.dart';
import 'package:wlcd/presentation/widgets/custom_bottom_sheet.dart';
import 'package:wlcd/presentation/widgets/image_view.dart';

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
            flexibleSpace: FlexibleSpaceBar(background: _ProfileHero(teacher: teacher)),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(AppPaddingWidth.p20, AppPaddingHeight.p20, AppPaddingWidth.p20, AppPaddingHeight.p40),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _StatsSection(teacher: teacher),
                SizedBox(height: AppHeight.h20),
                _ActionButtons(teacher: teacher),
                SizedBox(height: AppHeight.h24),
                const _ProfileTabs(),
                SizedBox(height: AppHeight.h28),
                _SectionCard(
                  title: 'نبذة عني',
                  icon: Icons.person_outline_rounded,
                  child: Text(
                    '${teacher.bio}\n\nأقدم تجربة تعليمية عملية تساعد المتعلمين على تحويل المعرفة إلى خطوات قابلة للتطبيق، مع تبسيط المفاهيم وبناء خطة واضحة للتطور المهني.',
                    textAlign: TextAlign.right,
                    style: TextStyle(color: AppColors.muted, fontSize: AppSize.s15, height: 1.8, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: AppHeight.h20),
                _SectionCard(
                  title: 'دوراتي',
                  icon: Icons.menu_book_outlined,
                  child: Column(
                    children: [
                      _CourseTile(color: teacher.accentColor, title: 'رحلة التعلم معي', subtitle: 'مسار تطبيقي يبدأ من الأساسيات حتى بناء مشروع عملي.'),
                      SizedBox(height: AppHeight.h12),
                      _CourseTile(color: AppColors.teacherGreen, title: teacher.specialty, subtitle: 'دروس قصيرة، تمارين، ومتابعة تساعدك على تحقيق نتائج واضحة.'),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero({required this.teacher});

  final TeacherData teacher;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(AppPaddingWidth.p20, AppPaddingHeight.p70, AppPaddingWidth.p20, AppPaddingHeight.p24),
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
            decoration: BoxDecoration(color: AppColors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: teacher.accentColor.withValues(alpha: .22), blurRadius: 30, offset: const Offset(0, 14))]),
            child: ClipOval(child: ImageView(imagePath: teacher.imageUrl, width: AppWidth.w110, height: AppHeight.h110, fit: BoxFit.cover)),
          ),
          SizedBox(height: AppHeight.h14),
          Text(teacher.name, style: TextStyle(color: AppColors.text, fontSize: AppSize.s24, fontWeight: FontWeight.w900)),
          SizedBox(height: AppHeight.h6),
          Text(teacher.specialty, style: TextStyle(color: teacher.accentColor, fontSize: AppSize.s14, fontWeight: FontWeight.w800)),
          SizedBox(height: AppHeight.h12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _SocialButton(icon: Icons.link_rounded),
              _SocialButton(icon: Icons.camera_alt_outlined),
              _SocialButton(icon: Icons.business_center_outlined),
              _SocialButton(icon: Icons.more_horiz_rounded),
            ],
          ),
        ],
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppWidth.w40,
      height: AppHeight.h40,
      margin: EdgeInsets.symmetric(horizontal: AppMarginWidth.m5),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(AppRadius.r14), border: Border.all(color: AppColors.teacherCardBorder)),
      child: Icon(icon, color: AppColors.teacherPurple, size: AppSize.s22),
    );
  }
}

class _StatsSection extends StatelessWidget {
  const _StatsSection({required this.teacher});

  final TeacherData teacher;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _StatCard(value: teacher.students, label: 'طالب', icon: Icons.groups_rounded, color: teacher.accentColor)),
        SizedBox(width: AppWidth.w12),
        Expanded(child: _StatCard(value: teacher.rating.toStringAsFixed(1), label: 'تقييم', icon: Icons.star_rounded, color: AppColors.teacherAmber)),
        SizedBox(width: AppWidth.w12),
        Expanded(child: _StatCard(value: '12', label: 'دورة', icon: Icons.play_lesson_rounded, color: AppColors.teacherGreen)),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.value, required this.label, required this.icon, required this.color});

  final String value;
  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppPaddingHeight.p14),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(AppRadius.r22), border: Border.all(color: AppColors.teacherCardBorder)),
      child: Column(
        children: [
          Icon(icon, color: color, size: AppSize.s22),
          SizedBox(height: AppHeight.h6),
          Text(value, style: TextStyle(color: AppColors.text, fontSize: AppSize.s17, fontWeight: FontWeight.w900)),
          SizedBox(height: AppHeight.h2),
          Text(label, style: TextStyle(color: AppColors.muted, fontSize: AppSize.s12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({required this.teacher});

  final TeacherData teacher;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ActionButton(label: 'احجز حصة', icon: Icons.calendar_month_rounded, color: AppColors.teacherGreen, onTap: () => _showBooking(context)),
        SizedBox(height: AppHeight.h12),
        _ActionButton(label: 'تواصل معي', icon: Icons.chat_bubble_outline_rounded, color: AppColors.seeMore, onTap: () {}),
        SizedBox(height: AppHeight.h12),
        _ActionButton(label: 'مشاركة', icon: Icons.share_rounded, color: AppColors.orange, onTap: () {}),
      ],
    );
  }

  void _showBooking(BuildContext context) {
    CustomBottomSheet.show(context, title: 'حجز جلسة', heightFactor: .75, borderRadius: AppRadius.r30, body: TeacherBookingSheet(teacher: teacher));
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.label, required this.icon, required this.color, required this.onTap});

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
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(AppRadius.r24), boxShadow: [BoxShadow(color: color.withValues(alpha: .22), blurRadius: 18, offset: const Offset(0, 10))]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.white, size: AppSize.s24),
            SizedBox(width: AppWidth.w10),
            Text(label, style: TextStyle(color: AppColors.white, fontSize: AppSize.s18, fontWeight: FontWeight.w900)),
          ],
        ),
      ),
    );
  }
}

class _ProfileTabs extends StatelessWidget {
  const _ProfileTabs();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _TabChip(label: 'معلومات عن المعلم', selected: true)),
        SizedBox(width: AppWidth.w10),
        Expanded(child: _TabChip(label: 'التقييمات', selected: false)),
        SizedBox(width: AppWidth.w10),
        Expanded(child: _TabChip(label: 'المكتبة', selected: false)),
      ],
    );
  }
}

class _TabChip extends StatelessWidget {
  const _TabChip({required this.label, required this.selected});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: AppPaddingHeight.p13),
      decoration: BoxDecoration(color: selected ? AppColors.seeMore : AppColors.white, borderRadius: BorderRadius.circular(AppRadius.r24), border: Border.all(color: selected ? AppColors.seeMore : AppColors.teacherCardBorder)),
      child: Text(label, textAlign: TextAlign.center, style: TextStyle(color: selected ? AppColors.white : AppColors.text, fontSize: AppSize.s13, fontWeight: FontWeight.w800)),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.icon, required this.child});

  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSize.s18),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(AppRadius.r28), border: Border.all(color: AppColors.teacherCardBorder), boxShadow: [BoxShadow(color: AppColors.blackCow.withValues(alpha: .05), blurRadius: 24, offset: const Offset(0, 12))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(title, style: TextStyle(color: AppColors.text, fontSize: AppSize.s20, fontWeight: FontWeight.w900)),
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

class _CourseTile extends StatelessWidget {
  const _CourseTile({required this.color, required this.title, required this.subtitle});

  final Color color;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSize.s12),
      decoration: BoxDecoration(color: AppColors.teacherBackground, borderRadius: BorderRadius.circular(AppRadius.r20), border: Border.all(color: AppColors.teacherCardBorder)),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Container(
            width: AppWidth.w70,
            height: AppHeight.h70,
            decoration: BoxDecoration(color: color.withValues(alpha: .14), borderRadius: BorderRadius.circular(AppRadius.r18)),
            child: Icon(Icons.school_rounded, color: color, size: AppSize.s30),
          ),
          SizedBox(width: AppWidth.w12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.right, style: TextStyle(color: AppColors.text, fontSize: AppSize.s16, fontWeight: FontWeight.w900)),
                SizedBox(height: AppHeight.h6),
                Text(subtitle, maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.right, style: TextStyle(color: AppColors.muted, fontSize: AppSize.s12, height: 1.45, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
