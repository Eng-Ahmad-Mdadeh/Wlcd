import 'package:flutter/material.dart';

class CategoryOption {
  const CategoryOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.lessonsCount,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final int lessonsCount;
}

const List<CategoryOption> categoryOptions = [
  CategoryOption(
    title: 'الرياضيات',
    subtitle: 'جبر، هندسة، إحصاء',
    icon: Icons.calculate_rounded,
    color: Color(0xFF1665E7),
    lessonsCount: 8,
  ),
  CategoryOption(
    title: 'الفيزياء',
    subtitle: 'حركة، طاقة، كهرباء',
    icon: Icons.science_rounded,
    color: Color(0xFF8B5CF6),
    lessonsCount: 14,
  ),
  CategoryOption(
    title: 'الكيمياء',
    subtitle: 'تفاعلات ومختبرات',
    icon: Icons.biotech_rounded,
    color: Color(0xFF14B8A6),
    lessonsCount: 1,
  ),
  CategoryOption(
    title: 'الأحياء',
    subtitle: 'خلايا، وراثة، جسم الإنسان',
    icon: Icons.eco_rounded,
    color: Color(0xFF22C55E),
    lessonsCount: 2,
  ),
  CategoryOption(
    title: 'اللغة العربية',
    subtitle: 'نحو، بلاغة، قراءة',
    icon: Icons.menu_book_rounded,
    color: Color(0xFFF59E0B),
    lessonsCount: 6,
  ),
  CategoryOption(
    title: 'اللغة الإنجليزية',
    subtitle: 'محادثة وقواعد',
    icon: Icons.translate_rounded,
    color: Color(0xFFEF4444),
    lessonsCount: 11,
  ),
];
