import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/progress_history/widgets/progress_history_data.dart';

class ProgressCourseThumb extends StatelessWidget {
  const ProgressCourseThumb({super.key, required this.type});

  final ProgressThumbType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppWidth.w80,
      height: AppHeight.h65,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppRadius.r8), gradient: _gradient),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(child: Container(color: AppColors.primary.withOpacity(.08))),
          if (type == ProgressThumbType.website) const _WebsiteThumbDetails() else const _FinanceThumbDetails(),
        ],
      ),
    );
  }

  LinearGradient get _gradient => switch (type) {
    ProgressThumbType.website => const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFCFDCE8), Color(0xFFF5F7FA), Color(0xFF8C5E4C), Color(0xFF302A2F)],
      stops: [0, .43, .44, 1],
    ),
    ProgressThumbType.finance => const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFF7C7C2), Color(0xFFF8E8E4), Color(0xFF7A80A4), Color(0xFF292D44)],
    ),
  };
}

class _WebsiteThumbDetails extends StatelessWidget {
  const _WebsiteThumbDetails();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PositionedDirectional(
          start: AppWidth.w8,
          top: AppHeight.h8,
          child: Container(
            width: AppWidth.w35,
            height: AppHeight.h25,
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(.75),
              borderRadius: BorderRadius.circular(AppRadius.r3),
              border: Border.all(color: AppColors.white.withOpacity(.9), width: AppWidth.w1),
            ),
          ),
        ),
        PositionedDirectional(
          start: AppWidth.w10,
          bottom: AppHeight.h11,
          child: Container(
            width: AppWidth.w50,
            height: AppHeight.h8,
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(.8),
              borderRadius: BorderRadius.circular(AppRadius.r5),
            ),
          ),
        ),
        PositionedDirectional(
          end: AppWidth.w8,
          top: AppHeight.h10,
          child: Icon(Icons.desktop_windows_outlined, size: AppSize.s22, color: AppColors.primary.withOpacity(.75)),
        ),
      ],
    );
  }
}

class _FinanceThumbDetails extends StatelessWidget {
  const _FinanceThumbDetails();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PositionedDirectional(
          start: AppWidth.w8,
          top: AppHeight.h8,
          child: Icon(Icons.account_balance_wallet_outlined, size: AppSize.s25, color: AppColors.white.withOpacity(.9)),
        ),
        PositionedDirectional(
          end: AppWidth.w8,
          bottom: AppHeight.h8,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _FinanceBar(height: AppHeight.h18, color: const Color(0xFFFFD7D3)),
              SizedBox(width: AppWidth.w4),
              _FinanceBar(height: AppHeight.h28, color: AppColors.white),
              SizedBox(width: AppWidth.w4),
              _FinanceBar(height: AppHeight.h38, color: const Color(0xFFFFB8AF)),
            ],
          ),
        ),
      ],
    );
  }
}

class _FinanceBar extends StatelessWidget {
  const _FinanceBar({required this.height, required this.color});

  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppWidth.w8,
      height: height,
      decoration: BoxDecoration(color: color.withOpacity(.9), borderRadius: BorderRadius.circular(AppRadius.r4)),
    );
  }
}
