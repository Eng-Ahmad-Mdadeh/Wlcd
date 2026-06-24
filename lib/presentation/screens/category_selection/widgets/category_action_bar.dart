import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';

class CategoryActionBar extends StatelessWidget {
  const CategoryActionBar({super.key, required this.selectedCount, required this.onClear, required this.onContinue});

  final int selectedCount;
  final VoidCallback? onClear;
  final VoidCallback? onContinue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPaddingWidth.p14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.r20),
        border: Border.all(color: AppColors.notificationBorder),
      ),
      child: Row(
        children: [
          Expanded(
            child: BodyTitle(
              text: selectedCount == 0 ? 'ابدأ باختيار التصنيفات المناسبة لك' : 'اختياراتك جاهزة — يمكنك المتابعة الآن',
              color: AppColors.seeMore,
              overflow: TextOverflow.visible,
              height: 1.35,
            ),
          ),
          TextButton(onPressed: onClear, child: const Text('مسح')),
          SizedBox(width: AppWidth.w8),
          ElevatedButton(
            onPressed: onContinue,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.r100)),
              padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p18, vertical: AppPaddingHeight.p12),
            ),
            child: Text('متابعة', style: TextStyle(fontSize: AppFontSize.s13, fontWeight: AppFontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
