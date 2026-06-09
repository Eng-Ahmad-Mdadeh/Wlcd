import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:wlcd/core/extension/localization_extension.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/custom_submit_button.dart';

class SaveButtonSection extends StatelessWidget {
  const SaveButtonSection({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(
        start: AppPaddingWidth.p20,
        end: AppPaddingWidth.p20,
        top: AppPaddingHeight.p15,
        bottom: AppPaddingHeight.p12,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.greySec,
            offset: const Offset(0, 3),
            blurRadius: 20,
            spreadRadius: 0,
          ),
        ],
      ),
      child: CustomSubmitButton(elevation: 0, title: "حفظ", onPressed: onPressed),
    ).animate().slideY(begin: .5, duration: const Duration(milliseconds: 200)).fadeIn();
  }
}
