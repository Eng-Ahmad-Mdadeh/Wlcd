import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';

class ForumGradientButton extends StatelessWidget {
  const ForumGradientButton({super.key, required this.label, required this.onPressed, this.icon});

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.primary, AppColors.accent]),
        borderRadius: BorderRadius.circular(AppRadius.r14),
        boxShadow: [BoxShadow(color: AppColors.searchBottomShadow, blurRadius: 18, offset: const Offset(0, 8))],
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p18, vertical: AppPaddingHeight.p12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.r14)),
        ),
        onPressed: onPressed,
        icon: icon == null ? const SizedBox.shrink() : Icon(icon, color: AppColors.white, size: 20),
        label: BodyTitle(text: label, color: AppColors.white, fontSize: 14, fontWeight: FontWeight.w700),
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
            if (icon != null) ...[
              Icon(icon, size: 18, color: AppColors.primary),
              SizedBox(width: AppWidth.w5),
            ],
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
