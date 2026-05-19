import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/custom_rich_text.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class NoteSection extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final List<CustomRichTextModel>? richTexts;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color backgroundColor;
  final CrossAxisAlignment crossAxisAlignment;
  final Function() onTap;

  const NoteSection({
    super.key,
    this.title,
    this.subTitle,
    this.richTexts,
    this.padding,
    this.margin,
    this.backgroundColor = AppColors.lightGrey,
    this.crossAxisAlignment = CrossAxisAlignment.center, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? EdgeInsetsDirectional.symmetric(vertical: AppPaddingHeight.p15, horizontal: AppPaddingWidth.p15),
      width: double.infinity,
      margin: margin ?? EdgeInsetsDirectional.only(top: AppMarginHeight.m33),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.r16),
      ),
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    final List<Widget> children = [];

    if (title != null) {
      children.add(
        BodyTitle(
          text: title,
          fontSize: AppFontSize.s15,
          color: AppColors.primary,
        ),
      );
    }

    if (title != null && (subTitle != null || richTexts != null)) {
      children.add(SizedBox(height: AppHeight.h5));
    }

    if (subTitle != null) {
      children.add(
        BodyTitle(
          text: subTitle!,
          fontSize: AppFontSize.s14,
          color: AppColors.blackText,
        ),
      );
    }

    if (richTexts != null) {
      if (subTitle != null && richTexts != null) {
        children.add(SizedBox(height: AppHeight.h5));
      }

      children.add(
        InkWell(onTap: onTap,child: CustomRichText(texts: richTexts!)),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      children: children,
    );
  }
}
