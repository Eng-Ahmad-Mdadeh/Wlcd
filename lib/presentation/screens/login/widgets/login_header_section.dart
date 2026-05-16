import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class LoginHeaderSection extends StatelessWidget {
  const LoginHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          text: 'Hi! Welcome Back',
          color: Color(0xFF1F2430),
          fontSize: 25,
          fontWeight: AppFontWeight.extraBold,
          height: 1,
        ),
        SizedBox(height: 8),
        SectionTitle(
          text:
              'We happy to see you again! to use your\naccount, you should sign in first.',
          color: Color(0xFF98A4B6),
          fontSize: 15,
          fontWeight: AppFontWeight.regular,
          height: 1.5,
          maxLines: 2,
        ),
      ],
    );
  }
}
