import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/notifications/widgets/notification_data.dart';

enum NotificationIconVariant { large, small }

class NotificationCircleIcon extends StatelessWidget {
  const NotificationCircleIcon({super.key, required this.type, required this.dimension, required this.iconVariant});

  final NotificationType type;
  final double dimension;
  final NotificationIconVariant iconVariant;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: dimension,
      height: dimension,
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.notificationBorder, width: AppWidth.w1),
      ),
      child: Center(child: _NotificationTypeIcon(type: type, variant: iconVariant)),
    );
  }
}

class _NotificationTypeIcon extends StatelessWidget {
  const _NotificationTypeIcon({required this.type, required this.variant});

  final NotificationType type;
  final NotificationIconVariant variant;

  double get _size => variant == NotificationIconVariant.large ? AppSize.s24 : AppSize.s20;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _size,
      height: _size,
      child: switch (type) {
        NotificationType.promotions => _PromotionsIcon(variant: variant),
        NotificationType.system => _SystemIcon(variant: variant),
        NotificationType.orders => _OrdersIcon(variant: variant),
        NotificationType.others => const _OthersIcon(),
      },
    );
  }
}

class _PromotionsIcon extends StatelessWidget {
  const _PromotionsIcon({required this.variant});

  final NotificationIconVariant variant;

  double get _ticketWidth => variant == NotificationIconVariant.large ? AppWidth.w19 : AppWidth.w16;
  double get _ticketHeight => variant == NotificationIconVariant.large ? AppHeight.h11 : AppHeight.h10;
  double get _starSize => variant == NotificationIconVariant.large ? AppSize.s5 : AppSize.s3;
  double get _dividerStart => variant == NotificationIconVariant.large ? AppWidth.w8 : AppWidth.w7;
  double get _dividerTop => variant == NotificationIconVariant.large ? AppHeight.h6 : AppHeight.h5;
  double get _dividerBottom => variant == NotificationIconVariant.large ? AppHeight.h5 : AppHeight.h4;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: _ticketWidth,
          height: _ticketHeight,
          decoration: BoxDecoration(
            color: AppColors.notificationPromotion,
            borderRadius: BorderRadius.circular(AppRadius.r2),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, color: AppColors.white, size: _starSize),
            SizedBox(width: AppWidth.w4),
            Icon(Icons.star, color: AppColors.white, size: _starSize),
          ],
        ),
        PositionedDirectional(
          start: _dividerStart,
          top: _dividerTop,
          bottom: _dividerBottom,
          child: Container(width: AppWidth.w1, color: AppColors.notificationPromotionDivider),
        ),
      ],
    );
  }
}

class _SystemIcon extends StatelessWidget {
  const _SystemIcon({required this.variant});

  final NotificationIconVariant variant;

  double get _lineStart => variant == NotificationIconVariant.large ? AppWidth.w4 : AppWidth.w3;
  double get _lineTopOne => variant == NotificationIconVariant.large ? AppHeight.h6 : AppHeight.h5;
  double get _lineTopTwo => variant == NotificationIconVariant.large ? AppHeight.h12 : AppHeight.h10;
  double get _lineTopThree => variant == NotificationIconVariant.large ? AppHeight.h18 : AppHeight.h15;
  double get _dotSize => variant == NotificationIconVariant.large ? AppSize.s3 : AppSize.s2;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        for (final top in [_lineTopOne, _lineTopTwo, _lineTopThree])
          PositionedDirectional(
            start: _lineStart,
            end: _lineStart,
            top: top,
            child: Container(height: AppHeight.h1, color: AppColors.notificationSystem),
          ),
        PositionedDirectional(start: AppWidth.w7, top: AppHeight.h4, child: _SystemDot(size: _dotSize)),
        PositionedDirectional(end: AppWidth.w6, top: AppHeight.h10, child: _SystemDot(size: _dotSize)),
        PositionedDirectional(start: AppWidth.w10, top: AppHeight.h16, child: _SystemDot(size: _dotSize)),
      ],
    );
  }
}

class _SystemDot extends StatelessWidget {
  const _SystemDot({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.notificationSystem, width: AppWidth.w1),
      ),
    );
  }
}

class _OrdersIcon extends StatelessWidget {
  const _OrdersIcon({required this.variant});

  final NotificationIconVariant variant;

  double get _giftWidth => variant == NotificationIconVariant.large ? AppWidth.w17 : AppWidth.w14;
  double get _giftHeight => variant == NotificationIconVariant.large ? AppHeight.h13 : AppHeight.h11;
  double get _giftTop => variant == NotificationIconVariant.large ? AppHeight.h6 : AppHeight.h5;
  double get _badgeSize => variant == NotificationIconVariant.large ? AppSize.s8 : AppSize.s6;
  double get _checkSize => variant == NotificationIconVariant.large ? AppSize.s5 : AppSize.s3;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Positioned(top: _giftTop, child: _GiftBox(width: _giftWidth, height: _giftHeight)),
        PositionedDirectional(
          end: AppWidth.w1,
          bottom: AppHeight.h2,
          child: Container(
            width: _badgeSize,
            height: _badgeSize,
            decoration: const BoxDecoration(color: AppColors.notificationSuccess, shape: BoxShape.circle),
            child: Icon(Icons.check, color: AppColors.white, size: _checkSize),
          ),
        ),
      ],
    );
  }
}

class _GiftBox extends StatelessWidget {
  const _GiftBox({required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              width: width - AppWidth.w2,
              height: height - AppHeight.h4,
              decoration: BoxDecoration(
                color: AppColors.notificationGiftBody,
                borderRadius: BorderRadius.circular(AppRadius.r2),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: width,
              height: AppHeight.h4,
              decoration: BoxDecoration(
                color: AppColors.notificationGiftTop,
                borderRadius: BorderRadius.circular(AppRadius.r2),
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            child: Container(width: AppWidth.w2, color: AppColors.notificationGiftRibbon),
          ),
        ],
      ),
    );
  }
}

class _OthersIcon extends StatelessWidget {
  const _OthersIcon();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(AppPaddingWidth.p4),
      mainAxisSpacing: AppHeight.h2,
      crossAxisSpacing: AppWidth.w2,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        4,
        (_) => Container(
          decoration: BoxDecoration(
            color: AppColors.notificationOthers,
            borderRadius: BorderRadius.circular(AppRadius.r2),
          ),
        ),
      ),
    );
  }
}
