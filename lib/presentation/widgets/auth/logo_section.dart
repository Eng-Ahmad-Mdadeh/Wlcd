import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_assets.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/image_view.dart';

class LogoSection extends StatelessWidget {
  const LogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        bottom: AppPaddingHeight.p20,
      ),
      child: ImageView(
        imagePath: AppAssets.logo,
        fit: BoxFit.contain,
        height: AppHeight.h160,
      ),
    );
  }
}
