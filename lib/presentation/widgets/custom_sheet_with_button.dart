import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/resources/app_colors.dart';
import '../../core/resources/app_values.dart';
import 'text/section_title.dart';

class CustomBottomSheetWithButton extends StatelessWidget {
  final String title;

  final Color barrierColor;
  final double heightFactor;
  final double borderRadius;
  final Color backgroundColor;
  final Color statusBarColor;
  final Brightness statusBarIconBrightness;
  final Widget body;
  final bool isScroll;
  final bool canPop;
  final EdgeInsetsGeometry? padding;
  final Widget? button;

  const CustomBottomSheetWithButton({
    super.key,
    required this.title,
    required this.borderRadius,
    required this.body,
    this.button,
    this.padding,
    this.barrierColor = Colors.black54,
    this.heightFactor = 1,
    this.backgroundColor = Colors.white,
    this.statusBarColor = Colors.transparent,
    this.isScroll = true,
    this.canPop = true,
    this.statusBarIconBrightness = Brightness.dark,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final keyboardHeight = mediaQuery.viewInsets.bottom;

    return PopScope(
      canPop: canPop,
      child: SafeArea(
        child: AnimatedContainer(
          // height: mediaQuery.size.height * heightFactor + keyboardHeight - 140.h,
          height: mediaQuery.size.height * heightFactor,
          duration: const Duration(milliseconds: 170),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(borderRadius),
                topLeft: Radius.circular(borderRadius),
              ),
            ),
            child: Column(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsetsDirectional.only(
                      top: AppPaddingHeight.p10,
                    ),
                    width: AppWidth.w132,
                    height: AppHeight.h7,
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(AppRadius.r35),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    top: AppPaddingHeight.p17,
                    bottom: AppPaddingHeight.p17,
                  ),
                  child: Center(
                    child: SectionTitle(
                      text: title,
                    ),
                  ),
                ),
                const Divider(
                  color: AppColors.lightBlack,
                  thickness: 0.1,
                  height: 0,
                ),
                Expanded(
                  child: CustomScrollView(
                    physics: isScroll ? null : const NeverScrollableScrollPhysics(),
                    slivers: [
                      SliverPadding(
                        padding: padding ?? const EdgeInsets.all(20.0),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              body,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if(  button!=null)
              button!
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Future<void> show(
    BuildContext context, {
    required String title,
    Color barrierColor = Colors.black54,
    double heightFactor = 0.955,
    double borderRadius = 20.0,
    bool enableDrag = true,
    bool isDismissible = true,
    bool canPop = true,
    Color backgroundColor = Colors.white,
    Color statusBarColor = Colors.transparent,
    Brightness statusBarIconBrightness = Brightness.dark,
    required Widget body,
    EdgeInsetsGeometry? padding,
    bool isScroll = true,
    required   Widget button
  }) {
    return showModalBottomSheet(
      barrierColor: barrierColor.withOpacity(.5),
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      builder: (context) => CustomBottomSheetWithButton(
        title: title,
        barrierColor: barrierColor,
        canPop: canPop,
        heightFactor: heightFactor,
        borderRadius: borderRadius,
        backgroundColor: backgroundColor,
        statusBarColor: statusBarColor,
        statusBarIconBrightness: statusBarIconBrightness,
        body: body,
        isScroll: isScroll,
        padding: padding,
        button: button,
      ),
    ).then(
      (value) => SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: statusBarColor,
          statusBarIconBrightness: statusBarIconBrightness,
        ),
      ),
    );
  }
}
