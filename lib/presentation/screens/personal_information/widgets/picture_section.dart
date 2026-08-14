import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';

import 'package:wlcd/presentation/widgets/image_view.dart';

class PictureSection extends StatelessWidget {
  final String? image;
  final VoidCallback? onTap;
  final bool isLoading;

  const PictureSection({super.key, this.image, this.onTap, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: onTap,
            child: Container(
              margin: EdgeInsetsDirectional.only(top: AppMarginHeight.m25),
              alignment: Alignment.center,
              width: AppWidth.w105,
              height: AppHeight.h105,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0XFFF5F7F9)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ImageView(
                    width: AppWidth.w105,
                    height: AppHeight.h105,
                    imagePath: image ?? '',
                    radius: BorderRadius.circular(100),
                    fit: BoxFit.cover,
                  ),
                  if (isLoading)
                    const CircularProgressIndicator(color: AppColors.primary),
                ],
              ),
            ),
          ),
          PositionedDirectional(
            top: AppHeight.h105,
            start: AppWidth.w5,
            child: Container(
              width: AppWidth.w20,
              height: AppHeight.h20,
              decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(AppRadius.r5)),
              child: Icon(Icons.edit_outlined, color: AppColors.white, size: AppSize.s17),
            ),
          ),
        ],
      ),
    );
  }
}
