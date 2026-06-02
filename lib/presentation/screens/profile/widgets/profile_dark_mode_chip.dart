import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';

class ProfileDarkModeChip extends StatelessWidget {
  const ProfileDarkModeChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppWidth.w34,
      height: AppHeight.h22,
      decoration: BoxDecoration(
        color: AppColors.profileChipBackground,
        borderRadius: BorderRadius.circular(AppRadius.r100),
      ),
      child: Icon(Icons.close, color: AppColors.profileChevron, size: AppSize.s13),
    );
  }
}
