import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/login/widgets/login_home_indicator.dart';

class NotificationsHomeIndicator extends StatelessWidget {
  const NotificationsHomeIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppHeight.h23,
      alignment: Alignment.topCenter,
      color: AppColors.notificationBackground,
      child: const LoginHomeIndicator(),
    );
  }
}
