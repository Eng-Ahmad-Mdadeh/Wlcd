import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class NotificationsTopBar extends StatelessWidget {
  const NotificationsTopBar({super.key, required this.onBackPressed});

  final VoidCallback onBackPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppHeight.h24,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: IconButton(
              onPressed: onBackPressed,
              padding: EdgeInsets.zero,
              constraints: BoxConstraints.tight(Size(AppWidth.w28, AppHeight.h28)),
              icon: Icon(Icons.arrow_back, color: AppColors.notificationTextPrimary, size: AppSize.s23),
            ),
          ),
          SectionTitle(
            text: 'Notifications',
            color: AppColors.notificationTextPrimary,
            fontSize: AppFontSize.s16,
            fontWeight: AppFontWeight.bold,
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: IconButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              constraints: BoxConstraints.tight(Size(AppWidth.w28, AppHeight.h28)),
              icon: Icon(Icons.more_vert, color: AppColors.notificationTextPrimary, size: AppSize.s23),
            ),
          ),
        ],
      ),
    );
  }
}
