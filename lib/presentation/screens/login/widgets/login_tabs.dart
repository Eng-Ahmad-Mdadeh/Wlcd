import 'package:flutter/material.dart';
import 'package:wlcd/core/extension/localization_extension.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class LoginTabs extends StatelessWidget {
  const LoginTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppHeight.h33,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.loginFieldBorder)),
      ),
      child: Row(
        children: [
          Expanded(child: LoginTab(label: context.loc.email, active: true)),
          Expanded(child: LoginTab(label: context.loc.phone_number)),
        ],
      ),
    );
  }
}

class LoginTab extends StatelessWidget {
  const LoginTab({super.key, required this.label, this.active = false});

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SectionTitle(
          text: label,
          color: active ? AppColors.loginTabActive : AppColors.loginTabInactive,
          fontSize: AppFontSize.s14,
          fontWeight: active ? AppFontWeight.bold : AppFontWeight.regular,
        ),
        if (active)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(height: AppHeight.h2, color: AppColors.loginTabIndicator),
          ),
      ],
    );
  }
}
