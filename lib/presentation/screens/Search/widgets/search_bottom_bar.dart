import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';

class SearchBottomBar extends StatelessWidget {
  const SearchBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppHeight.h92,
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.searchBottomBorder)),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(top: AppPaddingHeight.p16),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(icon: Iconsax.home_1_outline, label: 'Home'),
                _NavItem(icon: Iconsax.search_normal_1_outline, label: 'Explore', isActive: true),
                SizedBox(width: 54),
                _NavItem(icon: Iconsax.heart_outline, label: 'Wishlist'),
                _NavItem(icon: Iconsax.user_outline, label: 'Profile'),
              ],
            ),
          ),
          Positioned(
            top: -22,
            child: Container(
              width: AppWidth.w54,
              height: AppHeight.h54,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppRadius.r27),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.searchBottomShadow,
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(Iconsax.book_outline, color: AppColors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({required this.icon, required this.label, this.isActive = false});

  final IconData icon;
  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: isActive ? AppColors.primary : AppColors.searchNavInactiveIcon),
        SizedBox(height: AppHeight.h4),
        BodyTitle(
          text: label,
          fontSize: 12,
          color: isActive ? AppColors.primary : AppColors.searchNavInactiveText,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
        ),
      ],
    );
  }
}
