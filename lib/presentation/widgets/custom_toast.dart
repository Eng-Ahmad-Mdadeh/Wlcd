import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';

class CustomToast {
  static void show(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 4),
    Color backgroundColor = AppColors.red,
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (_) => Positioned(
        top: AppPaddingHeight.p50,
        right: AppPaddingWidth.p30,
        left: AppPaddingWidth.p30,
        child: Material(
          color: Colors.transparent,
          child: ToastWidget(
            message: message,
            backgroundColor: backgroundColor,
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // إزالة التوست بعد المدة المحددة
    // Future.delayed(duration, () {
    //   overlayEntry.remove();
    // });
  }
}

class ToastWidget extends StatelessWidget {
  final String message;
  final Color backgroundColor;

  const ToastWidget({
    super.key,
    required this.message,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: .9,
      duration: Duration(milliseconds: 350),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: AppPaddingHeight.p15),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: BodyTitle(
          text: message,
          color: AppColors.white,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
