import 'package:flutter/material.dart';
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
            color: const Color(0xFF202532),
            fontSize: 15,
            fontWeight: AppFontWeight.regular,
          ),
          CustomRichTextModel(
            text: 'Sign Up',
            color: const Color(0xFF222A61),
            fontSize: 15,
            fontWeight: AppFontWeight.extraBold,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
