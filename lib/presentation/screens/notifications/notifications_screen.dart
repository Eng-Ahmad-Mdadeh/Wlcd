import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/notifications/widgets/notification_data.dart';
import 'package:wlcd/presentation/screens/notifications/widgets/notifications_header.dart';
import 'package:wlcd/presentation/screens/notifications/widgets/notifications_home_indicator.dart';
import 'package:wlcd/presentation/screens/notifications/widgets/notifications_list.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'الإشعارات', centerTitle: true),
      backgroundColor: AppColors.notificationBackground,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: AppWidth.w428),
          child: const Column(
            children: [
              NotificationsHeader(filters: notificationFilters),
              Expanded(child: NotificationsList(notifications: notificationItems)),
              NotificationsHomeIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
