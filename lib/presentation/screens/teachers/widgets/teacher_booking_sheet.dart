import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/teachers/widgets/teacher_data.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class TeacherBookingSheet extends StatefulWidget {
  const TeacherBookingSheet({super.key, required this.teacher});

  final TeacherData teacher;

  @override
  State<TeacherBookingSheet> createState() => _TeacherBookingSheetState();
}

class _TeacherBookingSheetState extends State<TeacherBookingSheet> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = _dateOnly(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          text: 'اختر التاريخ المناسب لك',
          color: AppColors.text,
          fontSize: AppSize.s18,
        ),
        SizedBox(height: AppHeight.h16),
        _BookingCalendar(
          selectedDate: _selectedDate,
          color: widget.teacher.accentColor,
          onDateSelected: (date) {
            setState(() => _selectedDate = _dateOnly(date));
          },
        ),
      ],
    );
  }
}

class _BookingCalendar extends StatelessWidget {
  const _BookingCalendar({
    required this.selectedDate,
    required this.color,
    required this.onDateSelected,
  });

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
                  text: 'التقويم',
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
              final isSelected = _isSameDay(date, selectedDate);

              return _CalendarDay(
                date: date,
                color: color,
                isSelected: isSelected,
                onTap: () => onDateSelected(date),
              );
            },
          ),
        ],
      ),
    );
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
    required this.isSelected,
    required this.onTap,
  });

  final DateTime date;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textColor = isSelected ? AppColors.white : color;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.r16),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? color : AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.r16),
          border: Border.all(color: color.withValues(alpha: .3)),
        ),
        child: Center(
          child: BodyTitle(
            text: date.day.toString(),
            color: textColor,
            fontSize: AppSize.s14,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
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
