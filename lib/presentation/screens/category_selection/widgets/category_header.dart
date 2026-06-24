import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class CategoryHeader extends StatelessWidget {
  const CategoryHeader({super.key, required this.selectedCount});

  final int selectedCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPaddingWidth.p18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1F275D), Color(0xFF1665E7)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(AppRadius.r24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.18),
            blurRadius: AppRadius.r24,
            offset: Offset(0, AppHeight.h14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: AppWidth.w48,
                height: AppHeight.h48,
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(AppRadius.r16),
                ),
                child: Icon(Icons.auto_awesome_rounded, color: AppColors.white, size: AppSize.s24),
              ),
              SizedBox(width: AppWidth.w12),
              Expanded(
                child: SectionTitle(
                  text: 'ما التصنيفات التي تود تعلمها؟',
                  color: AppColors.white,
                  fontSize: AppFontSize.s19,
                  fontWeight: AppFontWeight.bold,
                  overflow: TextOverflow.visible,
                  height: 1.35,
                ),
              ),
            ],
          ),
          SizedBox(height: AppHeight.h14),
          BodyTitle(
            text: 'اختر تصنيفاً واحداً أو أكثر لنخصص لك الدورات والاقتراحات بناءً على أهدافك التعليمية.',
            color: AppColors.blueText,
            overflow: TextOverflow.visible,
            height: 1.45,
          ),
          SizedBox(height: AppHeight.h16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p12, vertical: AppPaddingHeight.p9),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(AppRadius.r100),
              border: Border.all(color: AppColors.white.withOpacity(0.2)),
            ),
            child: BodyTitle(
              text: selectedCount == 0 ? 'لم يتم اختيار أي تصنيف بعد' : 'تم اختيار $selectedCount تصنيف',
              color: AppColors.white,
              fontSize: AppFontSize.s12,
            ),
          ),
        ],
      ),
    );
  }
}
