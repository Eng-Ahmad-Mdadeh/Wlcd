import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/custom_drop_down_widget.dart';
import 'package:wlcd/presentation/widgets/custom_filter_chip.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';

class FilterRow extends StatelessWidget {
  const FilterRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _FilterBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Icon(Icons.tune, size: AppSize.s16, color: AppColors.grey),
                Spacer(),
                BodyTitle(text: 'Filter', fontSize: AppFontSize.s15, color: AppColors.greyText),
              ],
            ),
          ),
        ),
        SizedBox(width: AppWidth.w5,),
        Expanded(
          child: _FilterBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Icon(Icons.keyboard_arrow_down_rounded, size: AppSize.s16, color: AppColors.grey),
                Spacer(),
                BodyTitle(text: 'Sort', fontSize: AppFontSize.s15, color: AppColors.greyText),
              ],
            ),
          ),
        ),
        SizedBox(width: AppWidth.w5,)
,
        Expanded(
          child: _FilterBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Icon(Icons.keyboard_arrow_down_rounded,  size: AppSize.s16, color: AppColors.grey),
                Spacer(),
                BodyTitle(text: 'All levels', fontSize: AppFontSize.s15, color: AppColors.greyText),
              ],
            ),
          ),
        ),

      ],
    );
  }
}

class _FilterBox extends StatelessWidget {
  const _FilterBox({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppHeight.h38,
      padding: EdgeInsetsDirectional.symmetric(horizontal: AppPaddingWidth.p10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE5E6EA)),
      ),
      child: child,
    );
  }
}
