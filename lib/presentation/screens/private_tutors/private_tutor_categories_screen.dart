import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/presentation/screens/private_tutors/private_tutor_models.dart';
import 'package:wlcd/presentation/screens/private_tutors/private_tutor_tutors_screen.dart';
import 'package:wlcd/presentation/screens/private_tutors/private_tutor_widgets.dart';

class PrivateTutorCategoriesScreen extends StatelessWidget {
  const PrivateTutorCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrivateTutorScaffold(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(child: PrivateTutorHeroHeader()),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
            sliver: SliverList.list(
              children: [
                const SectionTitle(title: 'ما المادة التي تريد تقويتها؟', subtitle: 'تصنيفات مختارة بناءً على طلب الطلاب'),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: privateTutorCategories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: .92,
                  ),
                  itemBuilder: (context, index) {
                    final category = privateTutorCategories[index];
                    return _CategoryCard(category: category);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.category});

  final SubjectCategory category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(26),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => PrivateTutorTutorsScreen(category: category)),
      ),
      child: Ink(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(26),
          boxShadow: const [BoxShadow(color: Color(0x0F1F275D), blurRadius: 22, offset: Offset(0, 12))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: category.color.withOpacity(.12), borderRadius: BorderRadius.circular(20)),
              child: Icon(category.icon, color: category.color, size: 30),
            ),
            const Spacer(),
            Text(category.title, style: tutorTextStyle(19, FontWeight.w800, AppColors.text)),
            const SizedBox(height: 8),
            Text(category.description, style: tutorTextStyle(12, FontWeight.w500, AppColors.muted, height: 1.5)),
          ],
        ),
      ),
    );
  }
}
