import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/presentation/screens/private_tutors/private_tutor_models.dart';
import 'package:wlcd/presentation/screens/private_tutors/private_tutor_widgets.dart';

class PrivateTutorDetailsScreen extends StatefulWidget {
  const PrivateTutorDetailsScreen({super.key, required this.tutorName});

  final String tutorName;

  @override
  State<PrivateTutorDetailsScreen> createState() => _PrivateTutorDetailsScreenState();
}

class _PrivateTutorDetailsScreenState extends State<PrivateTutorDetailsScreen> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final tutor = privateTutors().firstWhere((item) => item.name == widget.tutorName, orElse: () => privateTutors().first);
    final days = nextSevenDays();

    return PrivateTutorScaffold(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: _TutorProfileHeader(tutor: tutor)),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
            sliver: SliverList.list(
              children: [
                _InfoCard(tutor: tutor),
                const SizedBox(height: 18),
                const SectionTitle(title: 'اختر تاريخ الحجز', subtitle: 'الأيام الخضراء متاحة، والرمادية محجوزة بالكامل'),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: days.map((date) {
                    final isBooked = tutor.bookedDays.contains(date.day);
                    final isSelected = _selectedDate?.day == date.day;
                    return _DateChip(
                      date: date,
                      isBooked: isBooked,
                      isSelected: isSelected,
                      onTap: isBooked ? null : () => setState(() => _selectedDate = date),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 22),
                _BookingButton(enabled: _selectedDate != null, tutorName: tutor.name),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TutorProfileHeader extends StatelessWidget {
  const _TutorProfileHeader({required this.tutor});

  final Tutor tutor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(gradient: LinearGradient(colors: [tutor.color, AppColors.primary]), borderRadius: BorderRadius.circular(32)),
      child: Column(
        children: [
          Align(alignment: Alignment.centerRight, child: BackCircleButton(onTap: () => Navigator.of(context).pop(), light: true)),
          TutorAvatar(initials: tutor.initials, color: AppColors.white, size: 96, textColor: tutor.color),
          const SizedBox(height: 14),
          Text(tutor.name, style: tutorTextStyle(24, FontWeight.w800, AppColors.white)),
          const SizedBox(height: 8),
          Text('${tutor.category} • ${tutor.experience}', style: tutorTextStyle(14, FontWeight.w500, const Color(0xFFEAF0FF))),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Metric(value: tutor.rating.toString(), label: 'التقييم'), const SizedBox(width: 10), Metric(value: tutor.sessions, label: 'جلسة')],
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.tutor});

  final Tutor tutor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(26), border: Border.all(color: const Color(0xFFECEEF6))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('نبذة عن المدرس', style: tutorTextStyle(18, FontWeight.w800, AppColors.text)),
          const SizedBox(height: 10),
          Text(tutor.fullBio, style: tutorTextStyle(13.5, FontWeight.w500, AppColors.muted, height: 1.75)),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: _DetailTile(icon: Icons.video_call_rounded, title: 'نوع الدرس', value: 'أونلاين مباشر')),
              Expanded(child: _DetailTile(icon: Icons.payments_rounded, title: 'السعر', value: tutor.price)),
            ],
          ),
        ],
      ),
    );
  }
}

class _DateChip extends StatelessWidget {
  const _DateChip({required this.date, required this.isBooked, required this.isSelected, required this.onTap});

  final DateTime date;
  final bool isBooked;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = isSelected ? AppColors.white : isBooked ? AppColors.navInactive : AppColors.darkGreen;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        width: 84,
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          color: isBooked ? const Color(0xFFE9ECF3) : isSelected ? AppColors.primary : const Color(0xFFEAF8F1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? AppColors.primary : Colors.transparent),
        ),
        child: Column(
          children: [
            Text(weekdayName(date.weekday), style: tutorTextStyle(12, FontWeight.w700, foregroundColor)),
            const SizedBox(height: 6),
            Text('${date.day}', style: tutorTextStyle(22, FontWeight.w900, isSelected ? AppColors.white : isBooked ? AppColors.navInactive : AppColors.text)),
            const SizedBox(height: 4),
            Text(isBooked ? 'محجوز' : 'متاح', style: tutorTextStyle(11, FontWeight.w700, foregroundColor)),
          ],
        ),
      ),
    );
  }
}

class _BookingButton extends StatelessWidget {
  const _BookingButton({required this.enabled, required this.tutorName});

  final bool enabled;
  final String tutorName;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: enabled ? AppColors.primary : AppColors.navInactive,
        foregroundColor: AppColors.white,
        minimumSize: const Size.fromHeight(56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 0,
      ),
      onPressed: enabled ? () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم إرسال طلب الحجز مع $tutorName'))) : null,
      child: Text(enabled ? 'تأكيد الحجز' : 'اختر تاريخاً متاحاً أولاً', style: tutorTextStyle(16, FontWeight.w800, AppColors.white)),
    );
  }
}

class _DetailTile extends StatelessWidget {
  const _DetailTile({required this.icon, required this.title, required this.value});

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.accent),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: tutorTextStyle(11, FontWeight.w600, AppColors.muted)),
              Text(value, style: tutorTextStyle(13, FontWeight.w800, AppColors.text)),
            ],
          ),
        ),
      ],
    );
  }
}
