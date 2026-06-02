import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class AboutTab extends StatelessWidget {
  const AboutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(AppPaddingWidth.p18, 0, AppPaddingWidth.p18, AppPaddingHeight.p90),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(text: 'Descriptions', fontSize: 18, color: AppColors.searchCardTitle),
          SizedBox(height: 8),
          BodyTitle(
            text:
                'Hi there! 👋 My name is Olivia Smith and welcome to this course. Digital products are more abstract and complex than any product you\'ve learned before. People are using their products in real-time and fast changing.',
            fontSize: 13,
            color: AppColors.searchRatingText,
            maxLines: 20,
          ),
        ],
      ),
    );
  }
}
