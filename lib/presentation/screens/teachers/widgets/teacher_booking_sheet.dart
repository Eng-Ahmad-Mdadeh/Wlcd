import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/teachers/widgets/teacher_data.dart';
import 'package:wlcd/presentation/widgets/custom_elevated_button.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class TeacherBookingSheet extends StatefulWidget {
  const TeacherBookingSheet({super.key, required this.teacher});

  final TeacherData teacher;

  @override
  State<TeacherBookingSheet> createState() => _TeacherBookingSheetState();
}

class _TeacherBookingSheetState extends State<TeacherBookingSheet> {
  late final List<_BookingSlot> _slots;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _slots = _BookingSlot.upcomingSlots();
    _selectedDate = _dateOnly(_slots.first.date);
  }

  @override
  Widget build(BuildContext context) {
    final selectedSlots = _slots.where((slot) => _isSameDay(slot.date, _selectedDate)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TeacherSummary(teacher: widget.teacher),
        SizedBox(height: AppHeight.h20),
        SectionTitle(
          text: 'اختر التاريخ المناسب لك',
          color: AppColors.text,
          fontSize: AppSize.s18,
        ),
        SizedBox(height: AppHeight.h6),
        BodyTitle(
          text: 'حدد يومًا من التقويم لعرض جلسات ${widget.teacher.name} المتاحة في هذا اليوم.',
          color: AppColors.muted,
          fontSize: AppSize.s13,
          height: AppLineHeight.teacherBio,
          overflow: TextOverflow.visible,
        ),
        SizedBox(height: AppHeight.h16),
        _BookingCalendar(
          slots: _slots,
          selectedDate: _selectedDate,
          color: widget.teacher.accentColor,
          onDateSelected: (date) {
            setState(() => _selectedDate = _dateOnly(date));
          },
        ),
        SizedBox(height: AppHeight.h20),
        SectionTitle(
          text: 'المواعيد المتاحة',
          color: AppColors.text,
          fontSize: AppSize.s17,
        ),
        SizedBox(height: AppHeight.h12),
        ...selectedSlots.map(
          (slot) => _BookingSlotCard(
            slot: slot,
            color: widget.teacher.accentColor,
          ),
        ),
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
            child: Icon(
              Icons.video_call_rounded,
              color: teacher.accentColor,
              size: AppSize.s27,
            ),
          ),
          SizedBox(width: AppWidth.w12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(
                  text: teacher.name,
                  color: AppColors.text,
                  fontSize: AppSize.s17,
                  maxLines: 1,
                ),
                SizedBox(height: AppHeight.h5),
                BodyTitle(
                  text: '${teacher.specialty} • جلسة 45 دقيقة',
                  color: AppColors.muted,
                  fontSize: AppSize.s13,
                  fontWeight: FontWeight.w500,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BookingCalendar extends StatelessWidget {
  const _BookingCalendar({
    required this.slots,
    required this.selectedDate,
    required this.color,
    required this.onDateSelected,
  });

  final List<_BookingSlot> slots;
  final DateTime selectedDate;
  final Color color;
  final ValueChanged<DateTime> onDateSelected;

  @override
  Widget build(BuildContext context) {
    final dates = _visibleCalendarDates();

    return Container(
      padding: EdgeInsets.all(AppSize.s14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .06),
        borderRadius: BorderRadius.circular(AppRadius.r24),
        border: Border.all(color: color.withValues(alpha: .14)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.calendar_month_rounded, color: color, size: AppSize.s22),
              SizedBox(width: AppWidth.w8),
              Expanded(
                child: SectionTitle(
                  text: 'تقويم المواعيد المتاحة',
                  color: AppColors.text,
                  fontSize: AppSize.s16,
                ),
              ),
            ],
          ),
          SizedBox(height: AppHeight.h14),
          Row(
            children: _weekDays
                .map(
                  (day) => Expanded(
                    child: Center(
                      child: BodyTitle(
                        text: day,
                        color: AppColors.muted,
                        fontSize: AppSize.s11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: AppHeight.h10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dates.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: DateTime.daysPerWeek,
              mainAxisSpacing: AppHeight.h8,
              crossAxisSpacing: AppWidth.w6,
            ),
            itemBuilder: (context, index) {
              final date = dates[index];
              final hasSlot = _hasSlot(date);
              final isSelected = _isSameDay(date, selectedDate);

              return _CalendarDay(
                date: date,
                color: color,
                hasSlot: hasSlot,
                isSelected: isSelected,
                onTap: hasSlot ? () => onDateSelected(date) : null,
              );
            },
          ),
        ],
      ),
    );
  }

  bool _hasSlot(DateTime date) {
    return slots.any((slot) => _isSameDay(slot.date, date));
  }

  List<DateTime> _visibleCalendarDates() {
    final today = _dateOnly(DateTime.now());
    final start = today.subtract(Duration(days: today.weekday - 1));

    return List.generate(
      DateTime.daysPerWeek * 5,
      (index) => start.add(Duration(days: index)),
    );
  }
}

class _CalendarDay extends StatelessWidget {
  const _CalendarDay({
    required this.date,
    required this.color,
    required this.hasSlot,
    required this.isSelected,
    required this.onTap,
  });

  final DateTime date;
  final Color color;
  final bool hasSlot;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textColor = isSelected
        ? AppColors.white
        : hasSlot
            ? color
            : AppColors.muted.withValues(alpha: .55);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.r16),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? color : AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.r16),
          border: Border.all(
            color: hasSlot ? color.withValues(alpha: .3) : AppColors.teacherCardBorder,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BodyTitle(
              text: date.day.toString(),
              color: textColor,
              fontSize: AppSize.s14,
              fontWeight: FontWeight.w800,
            ),
            SizedBox(height: AppHeight.h4),
            Container(
              width: AppSize.s5,
              height: AppSize.s5,
              decoration: BoxDecoration(
                color: hasSlot ? textColor : AppColors.none,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
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
            offset: Offset(0, AppHeight.h8),
          ),
        ],
      ),
      child: Row(
        children: [
          _SlotDateBadge(slot: slot, color: color),
          SizedBox(width: AppWidth.w14),
          Expanded(child: _SlotDetails(slot: slot)),
          SizedBox(width: AppWidth.w8),
          CustomElevatedButton(
            width: AppWidth.w90,
            height: AppHeight.h43,
            onPressed: () => context.pop(),
            color: color,
            borderRadius: AppRadius.r16,
            padding: EdgeInsets.zero,
            child: BodyTitle(
              text: 'حجز',
              color: AppColors.white,
              fontSize: AppSize.s13,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _SlotDateBadge extends StatelessWidget {
  const _SlotDateBadge({required this.slot, required this.color});

  final _BookingSlot slot;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppWidth.w60,
      padding: EdgeInsets.symmetric(vertical: AppPaddingHeight.p10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(AppRadius.r18),
      ),
      child: Column(
        children: [
          BodyTitle(
            text: slot.dayName,
            color: color,
            fontSize: AppSize.s12,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: AppHeight.h4),
          SectionTitle(
            text: slot.dayNumber,
            color: color,
            fontSize: AppSize.s24,
            fontWeight: FontWeight.w900,
          ),
          BodyTitle(
            text: slot.monthName,
            color: color,
            fontSize: AppSize.s11,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}

class _SlotDetails extends StatelessWidget {
  const _SlotDetails({required this.slot});

  final _BookingSlot slot;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          text: slot.title,
          color: AppColors.text,
          fontSize: AppSize.s15,
          fontWeight: FontWeight.w800,
          maxLines: 1,
        ),
        SizedBox(height: AppHeight.h6),
        Row(
          children: [
            Icon(
              Icons.access_time_rounded,
              size: AppSize.s16,
              color: AppColors.muted,
            ),
            SizedBox(width: AppWidth.w5),
            BodyTitle(
              text: slot.time,
              color: AppColors.muted,
              fontSize: AppSize.s12,
              fontWeight: FontWeight.w600,
              maxLines: 1,
            ),
          ],
        ),
      ],
    );
  }
}

class _BookingSlot {
  const _BookingSlot({
    required this.date,
    required this.time,
    required this.title,
  });

  final DateTime date;
  final String time;
  final String title;

  String get dayName => _arabicDays[date.weekday - 1];
  String get monthName => _arabicMonths[date.month - 1];
  String get dayNumber => date.day.toString();

  static List<_BookingSlot> upcomingSlots() {
    final today = DateTime.now();

    return [
      _BookingSlot(
        date: today.add(const Duration(days: 1)),
        time: '05:00 م - 05:45 م',
        title: 'جلسة استشارية فردية',
      ),
      _BookingSlot(
        date: today.add(const Duration(days: 3)),
        time: '07:30 م - 08:15 م',
        title: 'متابعة خطة التعلم',
      ),
      _BookingSlot(
        date: today.add(const Duration(days: 5)),
        time: '04:00 م - 04:45 م',
        title: 'جلسة تطبيق عملي',
      ),
      _BookingSlot(
        date: today.add(const Duration(days: 7)),
        time: '06:00 م - 06:45 م',
        title: 'جلسة أسئلة وإجابات',
      ),
    ];
  }
}

DateTime _dateOnly(DateTime date) => DateTime(date.year, date.month, date.day);

bool _isSameDay(DateTime first, DateTime second) {
  return first.year == second.year && first.month == second.month && first.day == second.day;
}

const _weekDays = [
  'إث',
  'ثل',
  'أر',
  'خم',
  'جم',
  'سب',
  'أح',
];

const _arabicDays = [
  'الإثنين',
  'الثلاثاء',
  'الأربعاء',
  'الخميس',
  'الجمعة',
  'السبت',
  'الأحد',
];

const _arabicMonths = [
  'يناير',
  'فبراير',
  'مارس',
  'أبريل',
  'مايو',
  'يونيو',
  'يوليو',
  'أغسطس',
  'سبتمبر',
  'أكتوبر',
  'نوفمبر',
  'ديسمبر',
];
