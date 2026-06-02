import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/notifications/widgets/notification_card.dart';
import 'package:wlcd/presentation/screens/notifications/widgets/notification_data.dart';

class NotificationsList extends StatelessWidget {
  const NotificationsList({super.key, required this.notifications});

  final List<NotificationItemData> notifications;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(AppWidth.w39, AppHeight.h17, AppWidth.w39, AppHeight.h22),
      physics: const BouncingScrollPhysics(),
      itemCount: notifications.length,
      separatorBuilder: (context, index) => SizedBox(height: AppHeight.h16),
      itemBuilder: (context, index) => NotificationCard(notification: notifications[index]),
    );
  }
}
