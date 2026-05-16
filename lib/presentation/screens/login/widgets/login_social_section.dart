import 'package:flutter/material.dart';
import 'package:wlcd/presentation/screens/login/widgets/or_divider.dart';
import 'package:wlcd/presentation/screens/login/widgets/sign_up_prompt.dart';
import 'package:wlcd/presentation/screens/login/widgets/social_button.dart';

class LoginSocialSection extends StatelessWidget {
  const LoginSocialSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        OrDivider(),
        SizedBox(height: 23),
        Row(
          children: [
            Expanded(child: SocialButton(icon: Icons.apple, label: 'Apple')),
            SizedBox(width: 12),
            Expanded(child: SocialButton(label: 'Google', google: true)),
          ],
        ),
        SizedBox(height: 15),
        SignUpPrompt(),
      ],
    );
  }
}
