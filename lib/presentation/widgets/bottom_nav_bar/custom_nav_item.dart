import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';

class CustomNavItem extends StatelessWidget {
  final void Function() onPressed;
  final String label;
  final IconData icon;
  final bool selected;

  const CustomNavItem({
    super.key,
    required this.onPressed,
    required this.label,
    required this.selected,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.none,
      highlightColor: AppColors.none,
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: AppPaddingWidth.p4),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                width: AppWidth.w70,
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeInOut,
                padding: EdgeInsetsDirectional.fromSTEB(
                  0,
                  AppPaddingHeight.p13,
                  0,
                  5,
                ),
                decoration: BoxDecoration(
                  color: selected ? AppColors.lightPrim : AppColors.none,
                  borderRadius: BorderRadius.circular(AppRadius.r18),
                ),
                child: Column(
                  children: [
                    Icon(
                      icon,
                      color: selected ? AppColors.primary : AppColors.navInactive,
                      size: AppSize.s20,
                    ),
                    SizedBox(height: AppHeight.h6),
                    BodyTitle(
                      text: label,
                      color: selected ? AppColors.primary : AppColors.seeMore,
                      fontWeight: AppFontWeight.extraBold,
                      fontSize: AppFontSize.s13,
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      width: AppWidth.w8,
                      height: AppHeight.h8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selected ? AppColors.primary : AppColors.none,
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
