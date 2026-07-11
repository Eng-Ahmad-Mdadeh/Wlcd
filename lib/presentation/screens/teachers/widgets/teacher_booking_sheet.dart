import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/teachers/widgets/teacher_data.dart';
import 'package:wlcd/presentation/widgets/custom_submit_button.dart';
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
  late DateTime _focusedDate;
  String? _selectedSlot;

  late final Map<DateTime, List<String>> _availableSlots = _buildAvailableSlots(DateTime.now());

  @override
  void initState() {
    super.initState();
    _selectedDate = _dateOnly(DateTime.now());
    _focusedDate = _selectedDate;
    _selectedSlot = _slotsFor(_selectedDate).firstOrNull;
  }

  @override
  Widget build(BuildContext context) {
    final selectedSlots = _slotsFor(_selectedDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(text: 'اختر التاريخ المناسب لك', color: AppColors.text, fontSize: AppSize.s18),
        SizedBox(height: AppHeight.h16),
        _BookingCalendar(
          selectedDate: _selectedDate,
          focusedDate: _focusedDate,
          color: widget.teacher.accentColor,
          availableDays: _availableSlots.keys.toSet(),
          onDateSelected: (selectedDate, focusedDate) {
            setState(() {
              _selectedDate = _dateOnly(selectedDate);
              _focusedDate = _dateOnly(focusedDate);
              _selectedSlot = _slotsFor(_selectedDate).firstOrNull;
            });
          },
          onPageChanged: (focusedDate) {
            setState(() => _focusedDate = _dateOnly(focusedDate));
          },
        ),
        SizedBox(height: AppHeight.h16),
        _SelectedDaySchedule(
          date: _selectedDate,
          slots: selectedSlots,
          selectedSlot: _selectedSlot,
          color: widget.teacher.accentColor,
          onSlotSelected: (slot) => setState(() => _selectedSlot = slot),
          onChatPressed: () {
            context.pop();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('سيتم الانتقال إلى المحادثة مع ${widget.teacher.name} قريباً')));
          },
        ),
        SizedBox(height: AppHeight.h16),
        if (selectedSlots.isNotEmpty)
          CustomSubmitButton(
            title: 'تأكيد الحجز',
            onPressed: () {
              context.pop();
            },
          ),
      ],
    );
  }

  List<String> _slotsFor(DateTime date) => _availableSlots[_dateOnly(date)] ?? const [];
}

class _BookingCalendar extends StatelessWidget {
  const _BookingCalendar({
    required this.selectedDate,
    required this.focusedDate,
    required this.color,
    required this.availableDays,
    required this.onDateSelected,
    required this.onPageChanged,
  });

  final DateTime selectedDate;
  final DateTime focusedDate;
  final Color color;
  final Set<DateTime> availableDays;
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
      child: TableCalendar<String>(
        locale: 'ar',
        firstDay: _dateOnly(DateTime.now()),
        lastDay: _dateOnly(DateTime.now().add(const Duration(days: 365))),
        focusedDay: focusedDate,
        selectedDayPredicate: (day) => isSameDay(day, selectedDate),
        eventLoader: (day) => availableDays.contains(_dateOnly(day)) ? const ['available'] : const [],
        onDaySelected: onDateSelected,
        onPageChanged: onPageChanged,
        calendarFormat: CalendarFormat.month,
        availableGestures: AvailableGestures.horizontalSwipe,
        startingDayOfWeek: StartingDayOfWeek.monday,
        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          leftChevronIcon: Icon(Icons.chevron_left_rounded, color: color, size: AppSize.s25),
          rightChevronIcon: Icon(Icons.chevron_right_rounded, color: color, size: AppSize.s25),
          titleTextStyle: TextStyle(color: AppColors.text, fontSize: AppSize.s16, fontWeight: FontWeight.w800),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(color: AppColors.muted, fontSize: AppSize.s11, fontWeight: FontWeight.w700),
          weekendStyle: TextStyle(color: AppColors.muted, fontSize: AppSize.s11, fontWeight: FontWeight.w700),
        ),
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          todayDecoration: BoxDecoration(color: color.withValues(alpha: .14), shape: BoxShape.circle),
          todayTextStyle: TextStyle(color: color, fontSize: AppSize.s14, fontWeight: FontWeight.w800),
          selectedDecoration: BoxDecoration(color: color, shape: BoxShape.circle),
          selectedTextStyle: TextStyle(color: AppColors.white, fontSize: AppSize.s14, fontWeight: FontWeight.w800),
          markerDecoration: BoxDecoration(color: AppColors.teacherGreen, shape: BoxShape.circle),
          markersMaxCount: 1,
          markerMargin: EdgeInsets.only(top: AppMarginHeight.m10),
          defaultTextStyle: TextStyle(color: AppColors.text, fontSize: AppSize.s14, fontWeight: FontWeight.w700),
          weekendTextStyle: TextStyle(color: AppColors.text, fontSize: AppSize.s14, fontWeight: FontWeight.w700),
          disabledTextStyle: TextStyle(
            color: AppColors.muted.withValues(alpha: .45),
            fontSize: AppSize.s14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _SelectedDaySchedule extends StatelessWidget {
  const _SelectedDaySchedule({
    required this.date,
    required this.slots,
    required this.selectedSlot,
    required this.color,
    required this.onSlotSelected,
    required this.onChatPressed,
  });

  final DateTime date;
  final List<String> slots;
  final String? selectedSlot;
  final Color color;
  final ValueChanged<String> onSlotSelected;
  final VoidCallback onChatPressed;

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('EEEE، d MMMM', 'ar').format(date);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSize.s18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.r24),
        border: Border.all(color: AppColors.teacherCardBorder),
        boxShadow: [
          BoxShadow(color: AppColors.blackCow.withValues(alpha: .04), blurRadius: 18, offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(
            text: 'مواعيد $formattedDate',
            textAlign: TextAlign.right,
            color: AppColors.text,
            fontSize: AppFontSize.s18,
            fontWeight: AppFontWeight.extraBold,
          ),
          SizedBox(height: AppHeight.h14),
          if (slots.isEmpty) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(AppSize.s16),
              decoration: BoxDecoration(
                color: color.withValues(alpha: .06),
                borderRadius: BorderRadius.circular(AppRadius.r18),
                border: Border.all(color: color.withValues(alpha: .12)),
              ),
              child: Column(
                children: [
                  BodyTitle(
                    text:
                        'لا توجد حصص متاحة في يوم $formattedDate. يمكنك اختيار يوم آخر من التقويم أو مراسلة المعلم لطلب مواعيد لهذا اليوم.',
                    textAlign: TextAlign.center,
                    color: AppColors.muted,
                    fontSize: AppFontSize.s15,
                    fontWeight: AppFontWeight.semiBold,
                    height: 1.7,
                    maxLines: 4,
                  ),
                  SizedBox(height: AppHeight.h14),
                  OutlinedButton.icon(
                    onPressed: onChatPressed,
                    icon: Icon(Icons.chat_bubble_outline_rounded, color: color),
                    label: SectionTitle(
                      text: 'تواصل مع المعلم',
                      color: color,
                      fontSize: AppFontSize.s15,
                      fontWeight: AppFontWeight.extraBold,
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, AppHeight.h54),
                      side: BorderSide(color: color, width: 1.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.r16)),
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            Wrap(
              spacing: AppWidth.w10,
              runSpacing: AppHeight.h10,
              alignment: WrapAlignment.end,
              children: slots.map((slot) {
                final selected = slot == selectedSlot;
                return ChoiceChip(
                  label: Text(slot),
                  selected: selected,
                  onSelected: (_) => onSlotSelected(slot),
                  selectedColor: color,
                  backgroundColor: AppColors.teacherBackground,
                  labelStyle: TextStyle(
                    color: selected ? AppColors.white : AppColors.text,
                    fontSize: AppFontSize.s14,
                    fontWeight: FontWeight.w800,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.r16),
                    side: BorderSide(color: selected ? color : AppColors.teacherCardBorder),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}

Map<DateTime, List<String>> _buildAvailableSlots(DateTime startDate) {
  final today = _dateOnly(startDate);

  return {
    today.add(const Duration(days: 1)): const ['09:00 ص', '11:30 ص', '05:00 م'],
    today.add(const Duration(days: 3)): const ['10:00 ص', '01:00 م'],
    today.add(const Duration(days: 5)): const ['04:00 م', '07:30 م'],
    today.add(const Duration(days: 8)): const ['12:00 م', '06:00 م'],
  };
}

DateTime _dateOnly(DateTime date) => DateTime(date.year, date.month, date.day);
