import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.loginDivider, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppWidth.w10),
          child: SectionTitle(
            text: 'Or with email',
            color: AppColors.loginDividerText,
            fontSize: AppFontSize.s13,
            fontWeight: AppFontWeight.regular,
          ),
        ),
        Expanded(child: Divider(color: AppColors.loginDivider, thickness: 1)),
      ],
    );
  }
}
