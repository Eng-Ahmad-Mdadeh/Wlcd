import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/notifications/widgets/notifications_home_indicator.dart';
import 'package:wlcd/presentation/screens/privacy_policy/widgets/privacy_policy_dummy_data.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      appBar: const CustomAppBar(title: 'سياسة الخصوصية', showBackButton: true),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: AppWidth.w428),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    AppPaddingWidth.p17,
                    AppPaddingHeight.p25,
                    AppPaddingWidth.p17,
                    AppPaddingHeight.p20,
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(AppPaddingWidth.p20),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppRadius.r13),
                      border: Border.all(color: AppColors.notificationBorder, width: AppWidth.w1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionTitle(text: 'بيانات تجريبية', maxLines: 2),
                        SizedBox(height: AppHeight.h16),
                        for (final section in privacyPolicyDummySections) ...[
                          BodyTitle(
                            text: section,
                            color: AppColors.notificationBodyText,
                            fontSize: AppFontSize.s14,
                            fontWeight: AppFontWeight.regular,
                            height: 1.7,
                            overflow: TextOverflow.visible,
                          ),
                          SizedBox(height: AppHeight.h16),
                        ],
                      ],
                    ),
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
