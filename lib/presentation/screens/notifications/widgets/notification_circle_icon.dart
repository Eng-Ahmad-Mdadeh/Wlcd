import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_assets.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/notifications/widgets/notification_data.dart';
import 'package:wlcd/presentation/widgets/image_view.dart';


class NotificationCircleIcon extends StatelessWidget {
  const NotificationCircleIcon({super.key, required this.type, required this.dimension});

  final NotificationType type;
  final double dimension;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: dimension,
      height: dimension,
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.notificationBorder, width: AppWidth.w1),
      ),
      child: Center(
        child: _NotificationTypeIcon(type: type,),
      ),
    );
  }
}

class _NotificationTypeIcon extends StatelessWidget {
  const _NotificationTypeIcon({required this.type});

  final NotificationType type;


  @override
  Widget build(BuildContext context) {
    return switch (type) {
      NotificationType.promotions => ImageView(imagePath: AppAssets.logo),
      NotificationType.system => ImageView(imagePath: AppAssets.logo),
      NotificationType.orders => ImageView(imagePath: AppAssets.logo),
      NotificationType.others => ImageView(imagePath: AppAssets.logo),
    };
  }
}
