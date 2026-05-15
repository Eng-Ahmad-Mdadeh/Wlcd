import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';

class DividerSection extends StatelessWidget {
  const DividerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        bottom: AppPaddingWidth.p45,
        start: AppPaddingWidth.p15,
        end: AppPaddingWidth.p15,
      ),
      child: const Divider(
        color: AppColors.greySec,
        thickness: .7,
      ),
    );
  }
}
