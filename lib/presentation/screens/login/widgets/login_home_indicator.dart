import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';

class LoginHomeIndicator extends StatelessWidget {
  const LoginHomeIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: AppWidth.w128,
        height: AppHeight.h4,
        decoration: BoxDecoration(
          color: AppColors.loginDarkText,
          borderRadius: BorderRadius.circular(AppRadius.r50),
        ),
      ),
    );
  }
}
