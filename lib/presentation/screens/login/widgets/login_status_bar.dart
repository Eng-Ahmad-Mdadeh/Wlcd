import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class LoginStatusBar extends StatelessWidget {
  const LoginStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppHeight.h22,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SectionTitle(
            text: '9:41',
            color: AppColors.loginDarkText,
            fontSize: AppFontSize.s14,
            fontWeight: AppFontWeight.semiBold,
          ),
          Row(
            children: [
              Icon(
                Icons.signal_cellular_alt,
                size: AppSize.s13,
                color: AppColors.loginDarkText,
              ),
              SizedBox(width: AppWidth.w5),
              Icon(Icons.wifi, size: AppSize.s13, color: AppColors.loginDarkText),
              SizedBox(width: AppWidth.w5),
              Icon(Icons.battery_full, size: AppSize.s13, color: AppColors.loginDarkText),
            ],
          ),
        ],
      ),
    );
  }
}
