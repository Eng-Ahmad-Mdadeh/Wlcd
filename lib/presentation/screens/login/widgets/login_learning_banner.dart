import 'package:flutter/material.dart';
import 'package:wlcd/core/extension/localization_extension.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class LoginLearningBanner extends StatelessWidget {
  const LoginLearningBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppHeight.h335,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.r4),
        gradient: const LinearGradient(
          colors: [Color(0xFF1F275D), Color(0xFF303C8F)],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1F275D).withOpacity(.18),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      clipBehavior: Clip.none,
      child: Stack(
        children: [
          const PositionedDirectional(
            top: 0,
            bottom: 0,
            end: 0,
            child: _CourseraStripes(),
          ),
          PositionedDirectional(
            start: AppWidth.w22,
            end: AppWidth.w96,
            top: AppHeight.h70,
            bottom: AppHeight.h24,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(
                  text: 'WLCD academy',
                  color: AppColors.white,
                  fontSize: AppFontSize.s28,
                  fontWeight: AppFontWeight.extraBold,
                  height: 1,
                ),
                SizedBox(height: AppHeight.h16),
                SectionTitle(
                  overflow: TextOverflow.visible,
                  text: context.loc.login_learning_banner_subtitle,
                  color: AppColors.white,
                  fontSize: AppFontSize.s18,
                  height: 1.55,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CourseraStripes extends StatelessWidget {
  const _CourseraStripes();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Stripe(width: AppWidth.w25, color: const Color(0xFF1F275D)),
        _Stripe(width: AppWidth.w28, color: const Color(0xFF303C8F)),
        _Stripe(width: AppWidth.w28, color: const Color(0xFF4A57B8)),
      ],
    );
  }
}

class _Stripe extends StatelessWidget {
  const _Stripe({required this.width, required this.color});

  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: BorderDirectional(
          start: BorderSide(
            color: const Color(0xFF1F275D).withOpacity(.2),
            width: 2,
          ),
        ),
      ),
    );
  }
}
