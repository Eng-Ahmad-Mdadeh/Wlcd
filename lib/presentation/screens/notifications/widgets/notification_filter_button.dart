import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/notifications/widgets/notification_circle_icon.dart';
import 'package:wlcd/presentation/screens/notifications/widgets/notification_data.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';

class NotificationFilterButton extends StatelessWidget {
  const NotificationFilterButton({super.key, required this.filter});

  final NotificationFilterData filter;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppWidth.w60,
      child: Column(
        children: [
          NotificationCircleIcon(
            type: filter.type,
            dimension: AppWidth.w48,
            iconVariant: NotificationIconVariant.large,
          ),
          SizedBox(height: AppHeight.h12),
          BodyTitle(
            text: filter.label,
            color: AppColors.notificationTextSecondary,
            fontSize: AppFontSize.s11,
            fontWeight: AppFontWeight.regular,
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
