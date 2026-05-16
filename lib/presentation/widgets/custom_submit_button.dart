import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_values.dart';
import 'custom_elevated_button.dart';
import 'text/section_title.dart';

class CustomSubmitButton extends StatelessWidget {
  final String title;
  final double? marginBottom;
  final double? marginTop;
  final double? marginStart;
  final double? marginEnd;
  final Function() onPressed;
  final bool verification;
  final bool? isLoading;
  final Color? loadingColor;
  final Color? buttonColor;
  final Color? textColor;
  final double? height;
  final double? borderRadius;
  final double? elevation;

  const CustomSubmitButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.marginBottom,
    this.marginTop,
    this.marginStart,
    this.marginEnd,
    this.verification = true,
    this.isLoading = false,
    this.loadingColor,
    this.buttonColor,
    this.textColor,
    this.height,
    this.borderRadius,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      height: height ?? AppHeight.h45,
      elevation: elevation ?? 5,
      marginBottom: marginBottom,
      marginTop: marginTop,
      marginStart: marginStart,
      marginEnd: marginEnd,
      width: double.infinity,
      color: verification ? (buttonColor ?? AppColors.primary) : AppColors.greyText,
      borderRadius: borderRadius ?? AppRadius.r7,
      onPressed: verification ? onPressed : () {},
      child: (isLoading ?? false)
          ? LoadingWidget(
              0,
              color: loadingColor ?? AppColors.primary,
              size: 30,
            )
          : SectionTitle(
              text: title,
              fontSize: AppFontSize.s14,
              color: textColor ?? AppColors.white,
            ),
    );
  }
}
