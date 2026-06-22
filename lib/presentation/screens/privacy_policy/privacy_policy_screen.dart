import 'package:flutter/material.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'سياسة الخصوصية', showBackButton: true),
      body: Center(child: BodyTitle(text: "سياسة الخصوصية")),
    );
  }
}
