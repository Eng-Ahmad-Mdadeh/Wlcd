import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/image_view.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p18),
          child: Column(
            children: [
              SizedBox(height: AppHeight.h10),
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back, color: AppColors.black),
                  ),
                  const Spacer(),
                  const Icon(Icons.ios_share_outlined, color: AppColors.black, size: 20),
                  SizedBox(width: AppWidth.w8),
                ],
              ),
              SizedBox(height: AppHeight.h10),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.r14),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const ImageView(
                      imagePath: 'https://images.unsplash.com/photo-1517048676732-d65bc937f952?w=1200',
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white.withValues(alpha: .35),
                      ),
                      child: const Icon(Icons.play_arrow_rounded, color: AppColors.white, size: 30),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppHeight.h14),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p8, vertical: AppPaddingHeight.p4),
                    decoration: BoxDecoration(
                      color: AppColors.searchTagBackground,
                      borderRadius: BorderRadius.circular(AppRadius.r8),
                    ),
                    child: const BodyTitle(text: 'UX Design', fontSize: 10, color: AppColors.searchTagText),
                  ),
                  const Spacer(),
                  const BodyTitle(text: '00', fontSize: 12, color: AppColors.searchRatingText),
                  SizedBox(width: AppWidth.w8),
                  const BodyTitle(text: 'All Levels', fontSize: 12, color: AppColors.searchCardTitle),
                ],
              ),
              SizedBox(height: AppHeight.h10),
              const SectionTitle(
                text: 'Master Digital Product Design:\nUX Research & UI Design',
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: AppColors.searchCardTitle,
                height: 1.3,
              ),
              SizedBox(height: AppHeight.h10),
              Row(
                children: [
                  const Icon(Icons.star, size: 16, color: AppColors.searchStar),
                  SizedBox(width: AppWidth.w5),
                  const BodyTitle(text: '4.5 (7,765)', fontSize: 12, color: AppColors.searchRatingText),
                  SizedBox(width: AppWidth.w10),
                  const BodyTitle(text: '1,768 enrolled', fontSize: 12, color: AppColors.searchRatingText),
                  SizedBox(width: AppWidth.w10),
                  const BodyTitle(text: '30+ Lessons', fontSize: 12, color: AppColors.searchRatingText),
                ],
              ),
              SizedBox(height: AppHeight.h14),
              LinearProgressIndicator(
                minHeight: 6,
                value: 0.30,
                borderRadius: BorderRadius.circular(AppRadius.r50),
                backgroundColor: AppColors.gray50,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
              SizedBox(height: AppHeight.h8),
              const Align(
                alignment: Alignment.centerLeft,
                child: BodyTitle(text: '30% from 24 sessions', fontSize: 12, color: AppColors.searchRatingText),
              ),
              SizedBox(height: AppHeight.h16),
              Container(
                padding: EdgeInsets.all(AppPaddingWidth.p4),
                decoration: BoxDecoration(
                  color: AppColors.gray50,
                  borderRadius: BorderRadius.circular(AppRadius.r12),
                ),
                child: Row(
                  children: const [
                    _TabChip(label: 'About', active: true),
                    _TabChip(label: 'Lessons', active: false),
                    _TabChip(label: 'Reviews', active: false),
                  ],
                ),
              ),
              SizedBox(height: AppHeight.h18),
              const Align(
                alignment: Alignment.centerLeft,
                child: SectionTitle(text: 'Descriptions', fontSize: 18, color: AppColors.searchCardTitle),
              ),
              SizedBox(height: AppHeight.h8),
              const Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: BodyTitle(
                    text:
                        'Hi there! 👋 My name is Olivia Smith and welcome to this course. Digital products are more abstract and complex than any product you\'ve learned before. People are using their products in real-time and fast changing.',
                    fontSize: 13,
                    color: AppColors.searchRatingText,
                    maxLines: 6,
                    height: 1.5,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: AppPaddingHeight.p14),
                child: Row(
                  children: [
                    Container(
                      height: AppHeight.h52,
                      width: AppWidth.w52,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.searchCardBorder),
                        borderRadius: BorderRadius.circular(AppRadius.r14),
                      ),
                      child: const Icon(Icons.favorite_border, color: AppColors.primary),
                    ),
                    SizedBox(width: AppWidth.w12),
                    Expanded(
                      child: SizedBox(
                        height: AppHeight.h52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.r28)),
                          ),
                          onPressed: () {},
                          child: const BodyTitle(text: 'Buy \$69.00', color: AppColors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  const _TabChip({required this.label, required this.active});

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: active ? AppColors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: BodyTitle(text: label, fontSize: 12, color: AppColors.searchCardTitle),
        ),
      ),
    );
  }
}
