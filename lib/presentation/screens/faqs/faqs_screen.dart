import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/faqs/widgets/faqs_dummy_data.dart';
import 'package:wlcd/presentation/screens/notifications/widgets/notifications_home_indicator.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class FaqsScreen extends StatelessWidget {
  const FaqsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      appBar: const CustomAppBar(title: 'الأسئلة الشائعة', showBackButton: true),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: AppWidth.w428),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.fromLTRB(
                    AppPaddingWidth.p17,
                    AppPaddingHeight.p25,
                    AppPaddingWidth.p17,
                    AppPaddingHeight.p20,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(AppPaddingWidth.p16),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(AppRadius.r13),
                        border: Border.all(color: AppColors.notificationBorder, width: AppWidth.w1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionTitle(text: 'سؤال تجريبي ${index + 1}', maxLines: 2),
                          SizedBox(height: AppHeight.h10),
                          BodyTitle(
                            text: faqsDummyQuestions[index],
                            color: AppColors.notificationBodyText,
                            fontSize: AppFontSize.s14,
                            fontWeight: AppFontWeight.regular,
                            height: 1.7,
                            overflow: TextOverflow.visible,
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: AppHeight.h14),
                  itemCount: faqsDummyQuestions.length,
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
