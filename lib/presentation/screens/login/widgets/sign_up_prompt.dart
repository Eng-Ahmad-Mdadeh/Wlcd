import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/presentation/widgets/custom_rich_text.dart';

class SignUpPrompt extends StatelessWidget {
  const SignUpPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomRichText(
        texts: [
          CustomRichTextModel(
            text: 'Don’t have an account? ',
            color: AppColors.loginSocialText,
            fontSize: AppFontSize.s15,
            fontWeight: AppFontWeight.regular,
          ),
          CustomRichTextModel(
            text: 'Sign Up',
            color: AppColors.loginTabIndicator,
            fontSize: AppFontSize.s15,
            fontWeight: AppFontWeight.extraBold,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
