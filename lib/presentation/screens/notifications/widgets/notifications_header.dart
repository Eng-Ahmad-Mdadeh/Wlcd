import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/login/widgets/login_status_bar.dart';
import 'package:wlcd/presentation/screens/notifications/widgets/notification_data.dart';
import 'package:wlcd/presentation/screens/notifications/widgets/notification_filter_button.dart';
import 'package:wlcd/presentation/screens/notifications/widgets/notifications_top_bar.dart';

class NotificationsHeader extends StatelessWidget {
  const NotificationsHeader({super.key, required this.filters});

  final List<NotificationFilterData> filters;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.fromLTRB(AppWidth.w38, AppHeight.h14, AppWidth.w38, AppHeight.h14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: filters.map((filter) => NotificationFilterButton(filter: filter)).toList(),
      ),
    );
  }
}
