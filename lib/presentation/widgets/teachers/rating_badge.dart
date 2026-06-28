import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';

class RatingBadge extends StatelessWidget {
  const RatingBadge({super.key, required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppPaddingWidth.p8,
        vertical: AppPaddingHeight.p5,
      ),
      decoration: BoxDecoration(
        color: AppColors.teacherRatingBackground,
        borderRadius: BorderRadius.circular(AppRadius.r100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star_rounded, color: AppColors.warning, size: AppSize.s15),
          SizedBox(width: AppWidth.w3),
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
              color: AppColors.text,
              fontSize: AppSize.s12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
