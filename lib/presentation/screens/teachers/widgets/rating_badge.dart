import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wlcd/core/resources/app_colors.dart';

class RatingBadge extends StatelessWidget {
  const RatingBadge({super.key, required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
      decoration: BoxDecoration(color: const Color(0xFFFFF7E8), borderRadius: BorderRadius.circular(100.r)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star_rounded, color: AppColors.warning, size: 15.r),
          SizedBox(width: 3.w),
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(color: AppColors.text, fontSize: 12.sp, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
