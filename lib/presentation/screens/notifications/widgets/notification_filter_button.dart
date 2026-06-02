import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/notifications/widgets/notification_circle_icon.dart';
import 'package:wlcd/presentation/screens/notifications/widgets/notification_data.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class NotificationFilterButton extends StatelessWidget {
  const NotificationFilterButton({super.key, required this.filter});

  final NotificationFilterData filter;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NotificationCircleIcon(type: filter.type, dimension: AppWidth.w55),
        SizedBox(height: AppHeight.h12),
        BodyTitle(text: filter.label, color: AppColors.primary, textAlign: TextAlign.center, maxLines: 1),
      ],
    );
  }
}
