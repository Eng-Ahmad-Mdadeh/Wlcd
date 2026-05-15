import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_fonts.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({
    super.key,
     this.text,
    this.textAlign,
    this.color,
    this.fontSize,
    this.overflow,
    this.fontWeight,
    this.decoration,
    this.decorationStyle,
    this.decorationColor,
    this.decorationThickness,
    this.maxLines,
    this.height,
  });

  final String ?text;
  final TextAlign? textAlign;
  final Color? color;
  final double? fontSize;
  final double? height;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;
  final TextDecorationStyle? decorationStyle;
  final Color? decorationColor;
  final double? decorationThickness;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text??'',
      textAlign: textAlign ?? TextAlign.center,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: color,
            fontSize: fontSize ?? AppFontSize.s30,
            fontWeight: fontWeight ?? AppFontWeight.extraBold,
            decoration: decoration,
            decorationStyle: decorationStyle,
            decorationColor: decorationColor,
            decorationThickness: decorationThickness,
            height: height,
          ),
    );
  }
}
