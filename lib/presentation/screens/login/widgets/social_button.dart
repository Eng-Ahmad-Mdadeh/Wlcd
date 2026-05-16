import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
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
      height: AppHeight.h49,
      elevation: 0,
      borderRadius: AppRadius.r8,
      color: AppColors.white,
      borderSide: const BorderSide(color: AppColors.loginFieldBorder),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (google)
            SectionTitle(
              text: 'G',
              color: AppColors.loginGoogleBlue,
              fontSize: AppFontSize.s16,
              fontWeight: AppFontWeight.bold,
            )
          else
            Icon(icon, size: AppSize.s19, color: AppColors.loginDarkText),
          SizedBox(width: AppWidth.w17),
          SectionTitle(
            text: label,
            color: AppColors.loginSocialText,
            fontSize: AppFontSize.s15,
            fontWeight: AppFontWeight.bold,
          ),
        ],
      ),
    );
  }
}
