import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/presentation/screens/private_tutors/private_tutor_details_screen.dart';
import 'package:wlcd/presentation/screens/private_tutors/private_tutor_models.dart';
import 'package:wlcd/presentation/screens/private_tutors/private_tutor_widgets.dart';

class PrivateTutorTutorsScreen extends StatelessWidget {
  const PrivateTutorTutorsScreen({super.key, required this.category});

  final SubjectCategory category;

  @override
  Widget build(BuildContext context) {
    final tutors = privateTutors().where((tutor) => tutor.category == category.title).toList();

    return PrivateTutorScaffold(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: PrivateTutorPageHeader(
              title: 'مدرسو ${category.title}',
              subtitle: '${tutors.length} مدرسين متاحين هذا الأسبوع',
              icon: category.icon,
              color: category.color,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
            sliver: SliverList.separated(
              itemCount: tutors.length,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (context, index) => _TutorCard(tutor: tutors[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _TutorCard extends StatelessWidget {
  const _TutorCard({required this.tutor});

  final Tutor tutor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(28),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => PrivateTutorDetailsScreen(tutor: tutor))),
      child: Ink(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: const Color(0xFFECEEF6)),
        ),
        child: Row(
          children: [
            TutorAvatar(initials: tutor.initials, color: tutor.color, size: 74),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(tutor.name, style: tutorTextStyle(18, FontWeight.w800, AppColors.text))),
                      const Icon(Icons.star_rounded, color: Color(0xFFFFB800), size: 19),
                      Text(' ${tutor.rating}', style: tutorTextStyle(13, FontWeight.w700, AppColors.text)),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Text(tutor.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: tutorTextStyle(12.5, FontWeight.w500, AppColors.muted, height: 1.55)),
                  const SizedBox(height: 10),
                  Row(children: [MiniPill(text: tutor.category), const SizedBox(width: 8), MiniPill(text: tutor.experience)]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
