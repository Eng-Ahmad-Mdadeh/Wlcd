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
        gradient: const LinearGradient(colors: [Color(0xFF1665E7), Color(0xFFC84EEA)]),
        borderRadius: BorderRadius.circular(AppRadius.r12),
        boxShadow: [BoxShadow(color: AppColors.searchBottomShadow, blurRadius: 16, offset: const Offset(0, 8))],
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p18, vertical: AppPaddingHeight.p12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.r12)),
        ),
        onPressed: onPressed,
        icon: icon == null ? const SizedBox.shrink() : Icon(icon, color: AppColors.white, size: 20),
        label: BodyTitle(text: label, color: AppColors.white, fontSize: 14),
      ),
    );
  }
}

class ForumActionButton extends StatelessWidget {
  const ForumActionButton({super.key, required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.r8),
      child: Padding(
        padding: EdgeInsets.all(AppPaddingWidth.p4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: AppColors.black),
            SizedBox(width: AppWidth.w5),
            BodyTitle(text: label, fontSize: 12, color: AppColors.searchRatingText),
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
