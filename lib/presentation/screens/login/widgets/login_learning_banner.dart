import 'package:flutter/material.dart';
import 'package:wlcd/core/extension/localization_extension.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class LoginLearningBanner extends StatelessWidget {
  const LoginLearningBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: AppWidth.w16, vertical: AppHeight.h14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.r24),
        gradient:  LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [Color(0xFFF3F7FF), Color(0xFFFFF8E8)],
        ),
        border: Border.all(color: AppColors.loginFieldBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.loginPrimary.withOpacity(.08),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        children: [
          const _LearningIllustration(),
          SizedBox(width: AppWidth.w14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SectionTitle(
                  text: context.loc.login_learning_banner_title,
                  color: AppColors.loginTitle,
                  fontSize: AppFontSize.s17,
                  fontWeight: AppFontWeight.bold,
                  height: 1.2,
                ),
                SizedBox(height: AppHeight.h6),
                BodyTitle(
                  overflow: TextOverflow.visible,
                  text: context.loc.login_learning_banner_subtitle,
                  color: AppColors.loginSubtitle,
                  fontSize: AppFontSize.s12,
                  fontWeight: AppFontWeight.regular,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LearningIllustration extends StatelessWidget {
  const _LearningIllustration();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppWidth.w70,
      height: AppWidth.w70,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.r22),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          PositionedDirectional(
            top: AppHeight.h10,
            end: AppWidth.w12,
            child: Icon(Icons.auto_awesome, color: AppColors.logoOrange, size: AppSize.s16),
          ),
          PositionedDirectional(
            bottom: AppHeight.h12,
            start: AppWidth.w12,
            child: Icon(Icons.school_outlined, color: AppColors.accent.withOpacity(.22), size: AppSize.s18),
          ),
          Container(
            width: AppWidth.w48,
            height: AppWidth.w48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.loginPrimary.withOpacity(.08),
            ),
            child: Icon(Icons.menu_book_rounded, color: AppColors.loginPrimary, size: AppSize.s30),
          ),
        ],
      ),
    );
  }
}
