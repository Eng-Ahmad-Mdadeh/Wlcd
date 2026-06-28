import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';
import 'package:wlcd/presentation/widgets/image_view.dart';

class TeachersScreen extends StatelessWidget {
  const TeachersScreen({super.key});

  static const List<_TeacherData> _teachers = [
    _TeacherData(
      name: 'د. سارة العلي',
      specialty: 'استراتيجية الأعمال',
      bio: 'تساعد المتعلمين على بناء خطط نمو عملية وربط المفاهيم النظرية بتحديات السوق اليومية.',
      rating: 4.9,
      students: '2.4k',
      imageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=480&q=80',
      accentColor: Color(0xFF6C63FF),
    ),
    _TeacherData(
      name: 'م. أحمد منصور',
      specialty: 'تحليل البيانات',
      bio: 'خبير في تحويل البيانات إلى قرارات واضحة من خلال أمثلة تطبيقية ولوحات معلومات تفاعلية.',
      rating: 4.8,
      students: '1.8k',
      imageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=480&q=80',
      accentColor: Color(0xFF16A3B8),
    ),
    _TeacherData(
      name: 'أ. ليان خالد',
      specialty: 'التسويق الرقمي',
      bio: 'تركز على بناء حملات تسويقية ذكية وتجارب محتوى تزيد التفاعل وتحسن نتائج العلامات التجارية.',
      rating: 4.7,
      students: '3.1k',
      imageUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=480&q=80',
      accentColor: Color(0xFFF59E0B),
    ),
    _TeacherData(
      name: 'د. يوسف ناصر',
      specialty: 'إدارة المشاريع',
      bio: 'يمزج بين الأطر الاحترافية وأدوات المتابعة الحديثة لإدارة فرق العمل وتسليم المشاريع بكفاءة.',
      rating: 4.9,
      students: '2.9k',
      imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=480&q=80',
      accentColor: Color(0xFF12B76A),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: CustomAppBar(
        title: 'المدرسون',
        centerTitle: true,
        backgroundColor: AppColors.primary,
        colorTitle: AppColors.white,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              AppPaddingWidth.p20,
              AppPaddingHeight.p10,
              AppPaddingWidth.p20,
              AppPaddingHeight.p30,
            ),
            sliver: SliverList.separated(
              itemCount: _teachers.length,
              separatorBuilder: (_, __) => SizedBox(height: 16.h),
              itemBuilder: (context, index) => _TeacherCard(teacher: _teachers[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _TeacherCard extends StatelessWidget {
  const _TeacherCard({required this.teacher});

  final _TeacherData teacher;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(26.r),
        border: Border.all(color: const Color(0xFFECEEF5)),
        boxShadow: [
          BoxShadow(color: AppColors.primary.withValues(alpha: .08), blurRadius: 24, offset: const Offset(0, 12)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TeacherPhoto(teacher: teacher),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        teacher.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: AppColors.text, fontSize: 17.sp, fontWeight: FontWeight.w800),
                      ),
                    ),
                    _RatingBadge(rating: teacher.rating),
                  ],
                ),
                SizedBox(height: 8.h),
                _SpecialtyChip(label: teacher.specialty, color: teacher.accentColor),
                SizedBox(height: 10.h),
                Text(
                  teacher.bio,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: AppColors.muted, fontSize: 12.5.sp, height: 1.55),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Icon(Icons.groups_rounded, size: 16.r, color: AppColors.accent),
                    SizedBox(width: 5.w),
                    Text(
                      '${teacher.students} طالب',
                      style: TextStyle(color: AppColors.seeMore, fontSize: 12.sp, fontWeight: FontWeight.w600),
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

class _TeacherPhoto extends StatelessWidget {
  const _TeacherPhoto({required this.teacher});

  final _TeacherData teacher;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88.w,
      height: 112.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.r),
        gradient: LinearGradient(
          colors: [teacher.accentColor.withValues(alpha: .22), teacher.accentColor.withValues(alpha: .06)],
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: ImageView(imagePath: teacher.imageUrl, fit: BoxFit.cover),
    );
  }
}

class _RatingBadge extends StatelessWidget {
  const _RatingBadge({required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
      decoration: BoxDecoration(color: const Color(0xFFFFF7E8), borderRadius: BorderRadius.circular(100.r)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star_rounded, color: AppColors.warning, size: 15.r),
          SizedBox(width: 3.w),
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(color: AppColors.text, fontSize: 12.sp, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

class _SpecialtyChip extends StatelessWidget {
  const _SpecialtyChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(color: color.withValues(alpha: .11), borderRadius: BorderRadius.circular(12.r)),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 12.sp, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _TeacherData {
  const _TeacherData({
    required this.name,
    required this.specialty,
    required this.bio,
    required this.rating,
    required this.students,
    required this.imageUrl,
    required this.accentColor,
  });

  final String name;
  final String specialty;
  final String bio;
  final double rating;
  final String students;
  final String imageUrl;
  final Color accentColor;
}
