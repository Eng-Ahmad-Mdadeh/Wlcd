import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class LoginHeaderSection extends StatelessWidget {
  const LoginHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          text: 'Hi! Welcome Back',
          color: AppColors.loginTitle,
          fontSize: AppFontSize.s25,
          fontWeight: AppFontWeight.extraBold,
          height: 1,
        ),
        SizedBox(height: AppHeight.h8),
        SectionTitle(
          text:
              'We happy to see you again! to use your\naccount, you should sign in first.',
          color: AppColors.loginSubtitle,
          fontSize: AppFontSize.s15,
          fontWeight: AppFontWeight.regular,
          height: 1.5,
          maxLines: 2,
        ),
      ],
    );
  }
}
