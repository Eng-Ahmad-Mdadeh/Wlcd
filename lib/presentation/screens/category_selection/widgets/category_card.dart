import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/category_selection/widgets/category_selection_data.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category, required this.isSelected, required this.onTap});

  final CategoryOption category;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.r22),
        border: Border.all(color: isSelected ? category.color : AppColors.notificationBorder, width: isSelected ? 1.6 : 1),
        boxShadow: [
          BoxShadow(
            color: (isSelected ? category.color : AppColors.primary).withOpacity(isSelected ? 0.16 : 0.05),
            blurRadius: isSelected ? AppRadius.r24 : AppRadius.r16,
            offset: Offset(0, AppHeight.h10),
          ),
        ],
      ),
      child: Material(
        color: AppColors.none,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.r22),
          child: Padding(
            padding: EdgeInsets.all(AppPaddingWidth.p14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: AppWidth.w45,
                      height: AppHeight.h45,
                      decoration: BoxDecoration(
                        color: category.color.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(AppRadius.r16),
                      ),
                      child: Icon(category.icon, color: category.color, size: AppSize.s24),
                    ),
                    const Spacer(),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 180),
                      child: Icon(
                        isSelected ? Icons.check_circle_rounded : Icons.add_circle_outline_rounded,
                        key: ValueKey(isSelected),
                        color: isSelected ? category.color : AppColors.profileIcon,
                        size: AppSize.s22,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SectionTitle(
                  text: category.title,
                  color: AppColors.text,
                  fontSize: AppFontSize.s16,
                  fontWeight: AppFontWeight.bold,
                  maxLines: 1,
                ),
                SizedBox(height: AppHeight.h6),
                BodyTitle(
                  text: category.subtitle,
                  color: AppColors.muted,
                  fontSize: AppFontSize.s12,
                  maxLines: 2,
                  height: 1.35,
                ),
                SizedBox(height: AppHeight.h12),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p10, vertical: AppPaddingHeight.p6),
                  decoration: BoxDecoration(color: category.color.withOpacity(0.1), borderRadius: BorderRadius.circular(AppRadius.r100)),
                  child: BodyTitle(
                    text: '${category.lessonsCount} مدرس',
                    color: category.color,
                    fontSize: AppFontSize.s11,
                    fontWeight: AppFontWeight.medium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
