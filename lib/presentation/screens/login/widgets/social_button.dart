import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/presentation/widgets/custom_elevated_button.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({super.key, required this.label, this.icon, this.google = false});

  final String label;
  final IconData? icon;
  final bool google;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      height: 49,
      elevation: 0,
      borderRadius: 8,
      color: AppColors.white,
      borderSide: const BorderSide(color: Color(0xFFEDF0F4)),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (google)
            const SectionTitle(
              text: 'G',
              color: Color(0xFF4285F4),
              fontSize: 16,
              fontWeight: AppFontWeight.bold,
            )
          else
            Icon(icon, size: 19, color: const Color(0xFF111827)),
          const SizedBox(width: 17),
          SectionTitle(
            text: label,
            color: const Color(0xFF202532),
            fontSize: 15,
            fontWeight: AppFontWeight.bold,
          ),
        ],
      ),
    );
  }
}
