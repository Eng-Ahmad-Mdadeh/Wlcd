import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/teachers/widgets/teacher_data.dart';
import 'package:wlcd/presentation/widgets/custom_elevated_button.dart';

class TeacherBookingSheet extends StatelessWidget {
  const TeacherBookingSheet({super.key, required this.teacher});

  final TeacherData teacher;

  @override
  Widget build(BuildContext context) {
    final slots = _BookingSlot.upcomingSlots();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TeacherSummary(teacher: teacher),
        SizedBox(height: AppHeight.h20),
        Text(
          'اختر الموعد المناسب لك',
          style: TextStyle(
            color: AppColors.text,
            fontSize: AppSize.s18,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: AppHeight.h6),
        Text(
          'التواريخ التالية متاحة لحجز جلسة مباشرة مع ${teacher.name}.',
          style: TextStyle(
            color: AppColors.muted,
            fontSize: AppSize.s13,
            height: AppLineHeight.teacherBio,
          ),
        ),
        SizedBox(height: AppHeight.h16),
        ...slots.map((slot) => _BookingSlotCard(slot: slot, color: teacher.accentColor)),
      ],
    );
  }
}

class _TeacherSummary extends StatelessWidget {
  const _TeacherSummary({required this.teacher});

  final TeacherData teacher;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSize.s14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            teacher.accentColor.withValues(alpha: .14),
            teacher.accentColor.withValues(alpha: .04),
          ],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
        borderRadius: BorderRadius.circular(AppRadius.r24),
        border: Border.all(color: teacher.accentColor.withValues(alpha: .16)),
      ),
      child: Row(
        children: [
          Container(
            width: AppWidth.w52,
            height: AppHeight.h52,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppRadius.r18),
            ),
            child: Icon(Icons.video_call_rounded, color: teacher.accentColor, size: AppSize.s27),
          ),
          SizedBox(width: AppWidth.w12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  teacher.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: AppSize.s17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: AppHeight.h5),
                Text(
                  '${teacher.specialty} • جلسة 45 دقيقة',
                  style: TextStyle(
                    color: AppColors.muted,
                    fontSize: AppSize.s13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BookingSlotCard extends StatelessWidget {
  const _BookingSlotCard({required this.slot, required this.color});

  final _BookingSlot slot;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppHeight.h12),
      padding: EdgeInsets.all(AppSize.s14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.r22),
        border: Border.all(color: AppColors.teacherCardBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackCow.withValues(alpha: .05),
            blurRadius: AppSize.s18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 64.0,
            padding: EdgeInsets.symmetric(vertical: AppPaddingHeight.p10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(AppRadius.r18),
            ),
            child: Column(
              children: [
                Text(slot.dayName, style: TextStyle(color: color, fontSize: AppSize.s12, fontWeight: FontWeight.w700)),
                SizedBox(height: AppHeight.h4),
                Text(slot.dayNumber, style: TextStyle(color: color, fontSize: AppSize.s24, fontWeight: FontWeight.w900)),
                Text(slot.monthName, style: TextStyle(color: color, fontSize: AppSize.s11, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          SizedBox(width: AppWidth.w14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(slot.title, style: TextStyle(color: AppColors.text, fontSize: AppSize.s15, fontWeight: FontWeight.w800)),
                SizedBox(height: AppHeight.h6),
                Row(
                  children: [
                    Icon(Icons.access_time_rounded, size: AppSize.s16, color: AppColors.muted),
                    SizedBox(width: AppWidth.w5),
                    Text(slot.time, style: TextStyle(color: AppColors.muted, fontSize: AppSize.s12, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: AppWidth.w8),
          SizedBox(
            width: AppWidth.w90,
            height: 42.0,
            child: CustomElevatedButton(
              onPressed: () => context.pop(context),
              color: color,
              borderRadius: AppRadius.r16,
              padding: EdgeInsets.zero,
              child: Text(
                'حجز',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: AppSize.s13,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BookingSlot {
  const _BookingSlot({required this.date, required this.time, required this.title});

  final DateTime date;
  final String time;
  final String title;

  String get dayName => _arabicDays[date.weekday - 1];
  String get monthName => _arabicMonths[date.month - 1];
  String get dayNumber => date.day.toString();

  static List<_BookingSlot> upcomingSlots() {
    final today = DateTime.now();
    return [
      _BookingSlot(date: today.add(const Duration(days: 1)), time: '05:00 م - 05:45 م', title: 'جلسة استشارية فردية'),
      _BookingSlot(date: today.add(const Duration(days: 3)), time: '07:30 م - 08:15 م', title: 'متابعة خطة التعلم'),
      _BookingSlot(date: today.add(const Duration(days: 5)), time: '04:00 م - 04:45 م', title: 'جلسة تطبيق عملي'),
      _BookingSlot(date: today.add(const Duration(days: 7)), time: '06:00 م - 06:45 م', title: 'جلسة أسئلة وإجابات'),
    ];
  }
}

const _arabicDays = ['الإثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت', 'الأحد'];
const _arabicMonths = ['يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو', 'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'];
