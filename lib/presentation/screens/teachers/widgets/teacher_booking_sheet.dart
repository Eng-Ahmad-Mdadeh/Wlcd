import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/teachers/widgets/teacher_data.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class TeacherBookingSheet extends StatefulWidget {
  const TeacherBookingSheet({super.key, required this.teacher});

  final TeacherData teacher;

  @override
  State<TeacherBookingSheet> createState() => _TeacherBookingSheetState();
}

class _TeacherBookingSheetState extends State<TeacherBookingSheet> {
  late DateTime _selectedDate;
  late DateTime _focusedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = _dateOnly(DateTime.now());
    _focusedDate = _selectedDate;
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
          focusedDate: _focusedDate,
          color: widget.teacher.accentColor,
          onDateSelected: (selectedDate, focusedDate) {
            setState(() {
              _selectedDate = _dateOnly(selectedDate);
              _focusedDate = _dateOnly(focusedDate);
            });
          },
          onPageChanged: (focusedDate) {
            setState(() => _focusedDate = _dateOnly(focusedDate));
          },
        ),
      ],
    );
  }
}

class _BookingCalendar extends StatelessWidget {
  const _BookingCalendar({
    required this.selectedDate,
    required this.focusedDate,
    required this.color,
    required this.onDateSelected,
    required this.onPageChanged,
  });

  final DateTime selectedDate;
  final DateTime focusedDate;
  final Color color;
  final OnDaySelected onDateSelected;
  final ValueChanged<DateTime> onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSize.s14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .06),
        borderRadius: BorderRadius.circular(AppRadius.r24),
        border: Border.all(color: color.withValues(alpha: .14)),
      ),
      child: Column(
        children: [
          TableCalendar<void>(
            locale: 'ar',
            firstDay: _dateOnly(DateTime.now()),
            lastDay: _dateOnly(DateTime.now().add(const Duration(days: 365))),
            focusedDay: focusedDate,
            selectedDayPredicate: (day) => isSameDay(day, selectedDate),
            onDaySelected: onDateSelected,
            onPageChanged: onPageChanged,
            calendarFormat: CalendarFormat.month,
            availableGestures: AvailableGestures.horizontalSwipe,
            startingDayOfWeek: StartingDayOfWeek.monday,
            headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              leftChevronIcon: Icon(
                Icons.chevron_left_rounded,
                color: color,
                size: AppSize.s26,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right_rounded,
                color: color,
                size: AppSize.s26,
              ),
              titleTextStyle: TextStyle(
                color: AppColors.text,
                fontSize: AppSize.s16,
                fontWeight: FontWeight.w800,
              ),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                color: AppColors.muted,
                fontSize: AppSize.s11,
                fontWeight: FontWeight.w700,
              ),
              weekendStyle: TextStyle(
                color: AppColors.muted,
                fontSize: AppSize.s11,
                fontWeight: FontWeight.w700,
              ),
            ),
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              todayDecoration: BoxDecoration(
                color: color.withValues(alpha: .14),
                shape: BoxShape.circle,
              ),
              todayTextStyle: TextStyle(
                color: color,
                fontSize: AppSize.s14,
                fontWeight: FontWeight.w800,
              ),
              selectedDecoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(
                color: AppColors.white,
                fontSize: AppSize.s14,
                fontWeight: FontWeight.w800,
              ),
              defaultTextStyle: TextStyle(
                color: AppColors.text,
                fontSize: AppSize.s14,
                fontWeight: FontWeight.w700,
              ),
              weekendTextStyle: TextStyle(
                color: AppColors.text,
                fontSize: AppSize.s14,
                fontWeight: FontWeight.w700,
              ),
              disabledTextStyle: TextStyle(
                color: AppColors.muted.withValues(alpha: .45),
                fontSize: AppSize.s14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DateTime _dateOnly(DateTime date) => DateTime(date.year, date.month, date.day);
