import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';

class LinearLoading extends StatelessWidget {
  const LinearLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: AppPaddingWidth.p20,
        end: AppPaddingWidth.p20,
        top: AppPaddingHeight.p80,
      ),
      child: LinearProgressIndicator(
        color: AppColors.primary,
        backgroundColor: AppColors.blueBackGround,
      ),
    );
  }
}
