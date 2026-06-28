import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_values.dart';

class SpecialtyChip extends StatelessWidget {
  const SpecialtyChip({super.key, required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppPaddingWidth.p10,
        vertical: AppPaddingHeight.p6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .11),
        borderRadius: BorderRadius.circular(AppRadius.r12),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: AppSize.s12, fontWeight: FontWeight.w700),
      ),
    );
  }
}
