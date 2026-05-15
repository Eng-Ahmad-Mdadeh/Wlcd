import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../core/resources/app_colors.dart';
import '../../core/resources/app_values.dart';

class LoadingWidget extends StatelessWidget {
  final int index;
  final double? size;
  final bool? noCenter;
  final Color? color;

  const LoadingWidget(this.index, {super.key, this.size, this.noCenter = false, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: AppWidth.w90,
        height: AppHeight.h90,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: AppWidth.w90,
              height: AppHeight.h90,
              child: const CircularProgressIndicator(
                strokeWidth: 2.8,
                valueColor: AlwaysStoppedAnimation(AppColors.primary),
              ),
            ),

            BodyTitle(
              text: 'wlcd',
              fontSize: AppFontSize.s16,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
