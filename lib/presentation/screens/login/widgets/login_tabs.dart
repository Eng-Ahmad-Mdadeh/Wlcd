import 'package:flutter/material.dart';
import 'package:wlcd/core/extension/localization_extension.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';

class LoginTabs extends StatelessWidget {
  const LoginTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: TabBar(
        indicatorColor: AppColors.loginTabIndicator,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: AppHeight.h2,
        dividerColor: Colors.transparent,
        labelColor: AppColors.loginTabActive,
        labelStyle: TextStyle(
          fontSize: AppFontSize.s14,
          fontWeight: AppFontWeight.bold,
        ),
        unselectedLabelColor: AppColors.loginTabInactive,
        unselectedLabelStyle: TextStyle(
          fontSize: AppFontSize.s14,
          fontWeight: AppFontWeight.regular,
        ),
        tabs: [
          Tab(text: context.loc.email),
          Tab(text: context.loc.phone_number),
        ],
      ),
    );
  }
}
