import 'package:flutter/material.dart';
import 'package:wlcd/core/extension/localization_extension.dart';
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
            text: context.loc.dont_have_account,
            color: AppColors.loginSocialText,
            fontSize: AppFontSize.s15,
            fontWeight: AppFontWeight.regular,
          ),
          CustomRichTextModel(
            text: context.loc.sign_up,
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
