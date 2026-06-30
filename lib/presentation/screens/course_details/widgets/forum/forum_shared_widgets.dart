import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/custom_elevated_button.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';

class ForumGradientButton extends StatelessWidget {
  const ForumGradientButton({super.key, required this.label, required this.onPressed, this.icon});

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      onPressed: onPressed,
      color: AppColors.primary,
      borderRadius: AppRadius.r9,
      child: Row(
        spacing: AppWidth.w5,
        children: [
          icon == null ? const SizedBox.shrink() : Icon(icon, color: AppColors.white, size: AppSize.s20),
          BodyTitle(text: label, color: AppColors.white),
        ],
      ),
    );
  }
}

class ForumOutlinedButton extends StatelessWidget {
  const ForumOutlinedButton({super.key, required this.label, required this.onTap, this.icon});

  final String label;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.r12),
      child: Ink(
        padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p12, vertical: AppPaddingHeight.p8),
        decoration: BoxDecoration(
          color: AppColors.lightBlue,
          borderRadius: BorderRadius.circular(AppRadius.r12),
          border: Border.all(color: AppColors.searchCardBorder),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[Icon(icon, size: 18, color: AppColors.primary), SizedBox(width: AppWidth.w5)],
            BodyTitle(text: label, fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w700),
          ],
        ),
      ),
    );
  }
}

String forumTimeAgo(DateTime dateTime) {
  final difference = DateTime.now().difference(dateTime);
  if (difference.inMinutes < 1) return 'الآن';
  if (difference.inHours < 1) return 'منذ ${difference.inMinutes} دقيقة';
  if (difference.inDays < 1) return 'منذ ${difference.inHours} ساعة';
  return 'منذ ${difference.inDays} يوم';
}
