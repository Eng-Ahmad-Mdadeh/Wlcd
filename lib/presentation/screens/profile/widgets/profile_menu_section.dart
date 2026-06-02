import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/profile/widgets/profile_menu_data.dart';
import 'package:wlcd/presentation/screens/profile/widgets/profile_menu_tile.dart';

class ProfileMenuSection extends StatelessWidget {
  const ProfileMenuSection({super.key, required this.items});

  final List<ProfileMenuItemData> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppMarginHeight.m20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.r13),
        border: Border.all(color: AppColors.notificationBorder, width: AppWidth.w1),
      ),
      child: Column(
        children: [
          for (int index = 0; index < items.length; index++)
            ProfileMenuTile(
              item: items[index],
              showDivider: index != items.length - 1,
            ),
        ],
      ),
    );
  }
}
