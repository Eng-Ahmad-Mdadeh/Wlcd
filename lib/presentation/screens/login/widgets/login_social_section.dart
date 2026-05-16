import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/login/widgets/or_divider.dart';
import 'package:wlcd/presentation/screens/login/widgets/sign_up_prompt.dart';
import 'package:wlcd/presentation/screens/login/widgets/social_button.dart';

class LoginSocialSection extends StatelessWidget {
  const LoginSocialSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OrDivider(),
        SizedBox(height: AppHeight.h23),
        Row(
          children: [
            Expanded(child: SocialButton(icon: Icons.apple, label: 'Apple')),
            SizedBox(width: AppWidth.w12),
            Expanded(child: SocialButton(label: 'Google', google: true)),
          ],
        ),
        SizedBox(height: AppHeight.h15),
        SignUpPrompt(),
      ],
    );
  }
}
