import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/notifications/widgets/notifications_home_indicator.dart';
import 'package:wlcd/presentation/screens/profile/widgets/profile_menu_data.dart';
import 'package:wlcd/presentation/screens/profile/widgets/profile_menu_section.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      appBar: const CustomAppBar(title: 'المزيد', centerTitle: true),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: AppWidth.w428),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    AppPaddingWidth.p17,
                    AppPaddingHeight.p35,
                    AppPaddingWidth.p17,
                    AppPaddingHeight.p20,
                  ),
                  child: const Column(
                    children: [
                      ProfileMenuSection(items: profileAccountItems),
                      ProfileMenuSection(items: profileBenefitsItems),
                      ProfileMenuSection(items: profileSupportItems),
                      ProfileMenuSection(items: profileSettingsItems),
                    ],
                  ),
                ),
              ),
              const NotificationsHomeIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
