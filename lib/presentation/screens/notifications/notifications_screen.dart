import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/login/widgets/login_home_indicator.dart';
import 'package:wlcd/presentation/screens/login/widgets/login_status_bar.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  static const List<_NotificationFilter> _filters = [
    _NotificationFilter(label: 'Promotions', type: _NotificationType.promotions),
    _NotificationFilter(label: 'System', type: _NotificationType.system),
    _NotificationFilter(label: 'Orders', type: _NotificationType.orders),
    _NotificationFilter(label: 'Others', type: _NotificationType.others),
  ];

  static const List<_NotificationItemData> _notifications = [
    _NotificationItemData(
      title: 'Congrats! Your order successful',
      category: 'Orders',
      type: _NotificationType.orders,
      description:
          'Semper consequat pharetra vitae nisl eget lectus. Convallis in turpis quam sed in. Vehicula diam euismod cursus posuere cras urna ultrice.',
      date: 'Jan 28, 2023 04:00 PM',
    ),
    _NotificationItemData(
      title: 'Changes in customer service time',
      category: 'Promotions',
      type: _NotificationType.promotions,
      description:
          'Semper consequat pharetra vitae nisl eget lectus. Convallis in turpis quam sed in. Vehicula diam euismod cursus posuere cras urna ultrice.',
      date: 'Jan 28, 2023 04:00 PM',
    ),
    _NotificationItemData(
      title: 'Changes in customer service time',
      category: 'Others',
      type: _NotificationType.others,
      description:
          'Semper consequat pharetra vitae nisl eget lectus. Convallis in turpis quam sed in. Vehicula diam euismod cursus posuere cras urna ultrice.',
      date: 'Jan 05, 2023 11:00 AM',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.notificationBackground,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: AppWidth.w428),
          child: Column(
            children: [
              const _NotificationsHeader(),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.fromLTRB(AppWidth.w39, AppHeight.h17, AppWidth.w39, AppHeight.h22),
                  physics: const BouncingScrollPhysics(),
                  itemCount: _notifications.length,
                  separatorBuilder: (context, index) => SizedBox(height: AppHeight.h16),
                  itemBuilder: (context, index) => _NotificationCard(notification: _notifications[index]),
                ),
              ),
              Container(
                height: AppHeight.h23,
                alignment: Alignment.topCenter,
                color: AppColors.notificationBackground,
                child: const LoginHomeIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationsHeader extends StatelessWidget {
  const _NotificationsHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppHeight.h230,
      color: AppColors.white,
      padding: EdgeInsets.fromLTRB(AppWidth.w38, AppHeight.h14, AppWidth.w38, 0),
      child: Column(
        children: [
          const LoginStatusBar(),
          SizedBox(height: AppHeight.h31),
          _TopBar(
            onBackPressed: () {
              if (context.canPop()) {
                context.pop();
              }
            },
          ),
          SizedBox(height: AppHeight.h33),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: NotificationsScreen._filters.map((filter) => _FilterButton(filter: filter)).toList(),
          ),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onBackPressed});

  final VoidCallback onBackPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppHeight.h24,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: IconButton(
              onPressed: onBackPressed,
              padding: EdgeInsets.zero,
              constraints: BoxConstraints.tight(Size(AppWidth.w28, AppHeight.h28)),
              icon: Icon(Icons.arrow_back, color: AppColors.notificationTextPrimary, size: AppSize.s23),
            ),
          ),
          SectionTitle(
            text: 'Notifications',
            color: AppColors.notificationTextPrimary,
            fontSize: AppFontSize.s16,
            fontWeight: AppFontWeight.bold,
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: IconButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              constraints: BoxConstraints.tight(Size(AppWidth.w28, AppHeight.h28)),
              icon: Icon(Icons.more_vert, color: AppColors.notificationTextPrimary, size: AppSize.s23),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({required this.filter});

  final _NotificationFilter filter;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppWidth.w60,
      child: Column(
        children: [
          _NotificationCircleIcon(
            type: filter.type,
            dimension: AppWidth.w48,
            iconVariant: _NotificationIconVariant.large,
          ),
          SizedBox(height: AppHeight.h12),
          BodyTitle(
            text: filter.label,
            color: AppColors.notificationTextSecondary,
            fontSize: AppFontSize.s11,
            fontWeight: AppFontWeight.regular,
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.notification});

  final _NotificationItemData notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: AppHeight.h160),
      padding: EdgeInsets.fromLTRB(AppWidth.w16, AppHeight.h17, AppWidth.w17, AppHeight.h17),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.r10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _NotificationCircleIcon(
            type: notification.type,
            dimension: AppWidth.w38,
            iconVariant: _NotificationIconVariant.small,
          ),
          SizedBox(width: AppWidth.w12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(
                  text: notification.title,
                  color: AppColors.notificationTextPrimary,
                  fontSize: AppFontSize.s13,
                  fontWeight: AppFontWeight.bold,
                  height: AppLineHeight.notificationTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: AppHeight.h5),
                BodyTitle(
                  text: notification.category,
                  color: AppColors.notificationTextMuted,
                  fontSize: AppFontSize.s11,
                  fontWeight: AppFontWeight.regular,
                  maxLines: 1,
                ),
                SizedBox(height: AppHeight.h15),
                BodyTitle(
                  text: notification.description,
                  color: AppColors.notificationBodyText,
                  fontSize: AppFontSize.s11,
                  fontWeight: AppFontWeight.regular,
                  height: AppLineHeight.notificationBody,
                  overflow: TextOverflow.visible,
                ),
                SizedBox(height: AppHeight.h16),
                BodyTitle(
                  text: notification.date,
                  color: AppColors.notificationDateText,
                  fontSize: AppFontSize.s11,
                  fontWeight: AppFontWeight.regular,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationCircleIcon extends StatelessWidget {
  const _NotificationCircleIcon({required this.type, required this.dimension, required this.iconVariant});

  final _NotificationType type;
  final double dimension;
  final _NotificationIconVariant iconVariant;

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

  final _NotificationType type;
  final _NotificationIconVariant variant;

  double get _size => variant == _NotificationIconVariant.large ? AppSize.s24 : AppSize.s20;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _size,
      height: _size,
      child: switch (type) {
        _NotificationType.promotions => _PromotionsIcon(variant: variant),
        _NotificationType.system => _SystemIcon(variant: variant),
        _NotificationType.orders => _OrdersIcon(variant: variant),
        _NotificationType.others => const _OthersIcon(),
      },
    );
  }
}

class _PromotionsIcon extends StatelessWidget {
  const _PromotionsIcon({required this.variant});

  final _NotificationIconVariant variant;

  double get _ticketWidth => variant == _NotificationIconVariant.large ? AppWidth.w19 : AppWidth.w16;
  double get _ticketHeight => variant == _NotificationIconVariant.large ? AppHeight.h11 : AppHeight.h10;
  double get _starSize => variant == _NotificationIconVariant.large ? AppSize.s5 : AppSize.s3;
  double get _dividerStart => variant == _NotificationIconVariant.large ? AppWidth.w8 : AppWidth.w7;
  double get _dividerTop => variant == _NotificationIconVariant.large ? AppHeight.h6 : AppHeight.h5;
  double get _dividerBottom => variant == _NotificationIconVariant.large ? AppHeight.h5 : AppHeight.h4;

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

  final _NotificationIconVariant variant;

  double get _lineStart => variant == _NotificationIconVariant.large ? AppWidth.w4 : AppWidth.w3;
  double get _lineTopOne => variant == _NotificationIconVariant.large ? AppHeight.h6 : AppHeight.h5;
  double get _lineTopTwo => variant == _NotificationIconVariant.large ? AppHeight.h12 : AppHeight.h10;
  double get _lineTopThree => variant == _NotificationIconVariant.large ? AppHeight.h18 : AppHeight.h15;
  double get _dotSize => variant == _NotificationIconVariant.large ? AppSize.s3 : AppSize.s2;

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

  final _NotificationIconVariant variant;

  double get _giftWidth => variant == _NotificationIconVariant.large ? AppWidth.w17 : AppWidth.w14;
  double get _giftHeight => variant == _NotificationIconVariant.large ? AppHeight.h13 : AppHeight.h11;
  double get _giftTop => variant == _NotificationIconVariant.large ? AppHeight.h6 : AppHeight.h5;
  double get _badgeSize => variant == _NotificationIconVariant.large ? AppSize.s8 : AppSize.s6;
  double get _checkSize => variant == _NotificationIconVariant.large ? AppSize.s5 : AppSize.s3;

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

class _NotificationFilter {
  const _NotificationFilter({required this.label, required this.type});

  final String label;
  final _NotificationType type;
}

class _NotificationItemData {
  const _NotificationItemData({
    required this.title,
    required this.category,
    required this.type,
    required this.description,
    required this.date,
  });

  final String title;
  final String category;
  final _NotificationType type;
  final String description;
  final String date;
}

enum _NotificationType { promotions, system, orders, others }

enum _NotificationIconVariant { large, small }
