import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class GuestContinueSection extends StatelessWidget {
  const GuestContinueSection({super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        SectionTitle(
          text: "continue as guest",
          fontSize: AppFontSize.s16,
          color: AppColors.primary,
          height: 0,
        ),
        SizedBox(
          width: AppWidth.w93,
          child: const Divider(
            color: AppColors.primary,
            height: 0,
          ),
        ),
      ],
    );
  }
}
