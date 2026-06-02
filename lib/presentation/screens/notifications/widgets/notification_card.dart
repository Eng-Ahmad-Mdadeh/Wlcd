import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/notifications/widgets/notification_circle_icon.dart';
import 'package:wlcd/presentation/screens/notifications/widgets/notification_data.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key, required this.notification});

  final NotificationItemData notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: AppHeight.h160),
      padding: EdgeInsets.fromLTRB(AppWidth.w16, AppHeight.h17, AppWidth.w17, AppHeight.h17),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.r10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NotificationCircleIcon(
            type: notification.type,
            dimension: AppWidth.w38,
            iconVariant: NotificationIconVariant.small,
          ),
          SizedBox(width: AppWidth.w12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(
                  text: notification.title,
                  color: AppColors.notificationTextPrimary,
                  fontSize: AppFontSize.s13,
                  fontWeight: AppFontWeight.bold,
                  height: AppLineHeight.notificationTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: AppHeight.h5),
                BodyTitle(
                  text: notification.category,
                  color: AppColors.notificationTextMuted,
                  fontSize: AppFontSize.s11,
                  fontWeight: AppFontWeight.regular,
                  maxLines: 1,
                ),
                SizedBox(height: AppHeight.h15),
                BodyTitle(
                  text: notification.description,
                  color: AppColors.notificationBodyText,
                  fontSize: AppFontSize.s11,
                  fontWeight: AppFontWeight.regular,
                  height: AppLineHeight.notificationBody,
                  overflow: TextOverflow.visible,
                ),
                SizedBox(height: AppHeight.h16),
                BodyTitle(
                  text: notification.date,
                  color: AppColors.notificationDateText,
                  fontSize: AppFontSize.s11,
                  fontWeight: AppFontWeight.regular,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
