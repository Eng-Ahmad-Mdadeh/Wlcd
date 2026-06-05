import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';

class OrderHistoryTabs extends StatelessWidget {
  const OrderHistoryTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppHeight.h40,
      padding: EdgeInsets.all(AppWidth.w3),
      decoration: BoxDecoration(
        color: AppColors.orderTabBackground,
        borderRadius: BorderRadius.circular(AppRadius.r8),
      ),
      child: Row(
        children: [
          Expanded(
            child: _OrderHistoryTabButton(
              label: 'Course',
              isSelected: true,
              onTap: () {},
            ),
          ),
          Expanded(
            child: _OrderHistoryTabButton(
              label: 'Refund',
              isSelected: false,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderHistoryTabButton extends StatelessWidget {
  const _OrderHistoryTabButton({required this.label, required this.isSelected, required this.onTap});

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.r7),
      splashColor: AppColors.none,
      highlightColor: AppColors.none,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.white : AppColors.none,
          borderRadius: BorderRadius.circular(AppRadius.r7),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.orderTabShadow,
                    blurRadius: AppWidth.w8,
                    offset: Offset(0, AppHeight.h3),
                  ),
                ]
              : null,
        ),
        child: BodyTitle(
          text: label,
          color: isSelected ? AppColors.orderTitle : AppColors.orderMuted,
          fontSize: AppFontSize.s12,
          fontWeight: isSelected ? AppFontWeight.bold : AppFontWeight.medium,
        ),
      ),
    );
  }
}
