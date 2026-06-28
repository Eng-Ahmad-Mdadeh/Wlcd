import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpecialtyChip extends StatelessWidget {
  const SpecialtyChip({super.key, required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(color: color.withValues(alpha: .11), borderRadius: BorderRadius.circular(12.r)),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 12.sp, fontWeight: FontWeight.w700),
      ),
    );
  }
}
