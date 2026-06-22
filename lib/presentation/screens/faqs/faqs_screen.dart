import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';

class FaqsScreen extends StatelessWidget {
  const FaqsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      appBar: const CustomAppBar(title: 'الأسئلة الشائعة', showBackButton: true),
      body: Center(child: BodyTitle(text: "الأسئلة الشائعة")),
    );
  }
}
