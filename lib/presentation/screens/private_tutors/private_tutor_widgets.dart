import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/presentation/screens/private_tutors/private_tutor_models.dart';

TextStyle tutorTextStyle(double size, FontWeight weight, Color color, {double? height}) {
  return TextStyle(fontFamily: AppFontFamily.rubik, fontSize: size, fontWeight: weight, color: color, height: height);
}

class PrivateTutorScaffold extends StatelessWidget {
  const PrivateTutorScaffold({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7FB),
        body: SafeArea(child: child),
      ),
    );
  }
}

class PrivateTutorHeroHeader extends StatelessWidget {
  const PrivateTutorHeroHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.primary, Color(0xFF3654D4)], begin: Alignment.topRight, end: Alignment.bottomLeft),
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [BoxShadow(color: Color(0x331F275D), blurRadius: 28, offset: Offset(0, 16))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SoftChip(text: 'جلسات مباشرة • مواعيد مرنة'),
          const SizedBox(height: 22),
          Text('إحجز مدرسك الخصوصي بثقة', style: tutorTextStyle(28, FontWeight.w800, AppColors.white, height: 1.25)),
          const SizedBox(height: 12),
          Text('اختر المادة، قارن بين أفضل المدرسين، ثم احجز موعداً مناسباً خلال دقائق.', style: tutorTextStyle(14, FontWeight.w400, const Color(0xFFE6EAFF), height: 1.7)),
          const SizedBox(height: 22),
          const Row(
            children: [
              Metric(value: '+48', label: 'مدرس خبير'),
              SizedBox(width: 12),
              Metric(value: '4.9', label: 'تقييم الطلاب'),
            ],
          ),
        ],
      ),
    );
  }
}

class PrivateTutorPageHeader extends StatelessWidget {
  const PrivateTutorPageHeader({super.key, required this.title, required this.subtitle, required this.icon, required this.color});

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          BackCircleButton(onTap: () => Navigator.of(context).pop()),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: color.withOpacity(.13), borderRadius: BorderRadius.circular(18)),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: tutorTextStyle(24, FontWeight.w800, AppColors.text)),
                const SizedBox(height: 6),
                Text(subtitle, style: tutorTextStyle(13, FontWeight.w500, AppColors.muted)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: tutorTextStyle(22, FontWeight.w800, AppColors.text)),
        const SizedBox(height: 6),
        Text(subtitle, style: tutorTextStyle(13, FontWeight.w500, AppColors.muted)),
      ],
    );
  }
}

class TutorAvatar extends StatelessWidget {
  const TutorAvatar({super.key, required this.initials, required this.color, required this.size, this.textColor = AppColors.white});

  final String initials;
  final Color color;
  final Color textColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: const [BoxShadow(color: Color(0x1A000000), blurRadius: 18, offset: Offset(0, 10))],
      ),
      child: Text(initials, style: tutorTextStyle(size * .28, FontWeight.w900, textColor)),
    );
  }
}

class BackCircleButton extends StatelessWidget {
  const BackCircleButton({super.key, required this.onTap, this.light = false});

  final VoidCallback onTap;
  final bool light;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: light ? AppColors.white.withOpacity(.16) : AppColors.white,
      shape: const CircleBorder(),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(Icons.arrow_back_ios_new_rounded, color: light ? AppColors.white : AppColors.primary, size: 18),
      ),
    );
  }
}

class Metric extends StatelessWidget {
  const Metric({super.key, required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(color: AppColors.white.withOpacity(.14), borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Text(value, style: tutorTextStyle(18, FontWeight.w900, AppColors.white)),
          Text(label, style: tutorTextStyle(11, FontWeight.w500, const Color(0xFFEAF0FF))),
        ],
      ),
    );
  }
}

class SoftChip extends StatelessWidget {
  const SoftChip({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: AppColors.white.withOpacity(.14), borderRadius: BorderRadius.circular(999)),
      child: Text(text, style: tutorTextStyle(12, FontWeight.w700, AppColors.white)),
    );
  }
}

class MiniPill extends StatelessWidget {
  const MiniPill({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: const Color(0xFFF0F3FF), borderRadius: BorderRadius.circular(999)),
      child: Text(text, style: tutorTextStyle(11, FontWeight.w700, AppColors.primary)),
    );
  }
}

String weekdayName(int day) => const ['الإث', 'الثلا', 'الأرب', 'الخمي', 'الجم', 'السب', 'الأحد'][day - 1];
