import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class SectionHeaderRow extends StatelessWidget {
  const SectionHeaderRow({super.key, required this.title, this.actionText, this.onActionPressed});

  final String title;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SectionTitle(text: title, color: AppColors.text, fontSize: AppFontSize.s15, fontWeight: AppFontWeight.extraBold),
        if (actionText != null)
          TextButton(
            onPressed: onActionPressed,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              foregroundColor: AppColors.seeMore,
            ),
            child: BodyTitle(
              text: actionText!,
              color: AppColors.seeMore,
              fontSize: AppFontSize.s12,
              fontWeight: AppFontWeight.bold,
            ),
          ),
      ],
    );
  }
}
