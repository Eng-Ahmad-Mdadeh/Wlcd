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
          _NotificationCircleIcon(type: filter.type, size: AppSize.s24, dimension: AppWidth.w48),
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
          _NotificationCircleIcon(type: notification.type, size: AppSize.s20, dimension: AppWidth.w38),
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
                  height: 1.16,
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
                  height: 1.45,
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
  const _NotificationCircleIcon({required this.type, required this.size, required this.dimension});

  final _NotificationType type;
  final double size;
  final double dimension;

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
      child: Center(child: _NotificationTypeIcon(type: type, size: size)),
    );
  }
}

class _NotificationTypeIcon extends StatelessWidget {
  const _NotificationTypeIcon({required this.type, required this.size});

  final _NotificationType type;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: switch (type) {
        _NotificationType.promotions => _PromotionsIcon(size: size),
        _NotificationType.system => _SystemIcon(size: size),
        _NotificationType.orders => _OrdersIcon(size: size),
        _NotificationType.others => _OthersIcon(size: size),
      },
    );
  }
}

class _PromotionsIcon extends StatelessWidget {
  const _PromotionsIcon({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size * .78,
          height: size * .47,
          decoration: BoxDecoration(
            color: AppColors.notificationPromotion,
            borderRadius: BorderRadius.circular(AppRadius.r2),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, color: AppColors.white, size: size * .22),
            SizedBox(width: AppWidth.w4),
            Icon(Icons.star, color: AppColors.white, size: size * .22),
          ],
        ),
        Positioned(
          left: size * .35,
          top: size * .27,
          bottom: size * .22,
          child: Container(width: AppWidth.w1, color: AppColors.notificationPromotionDivider),
        ),
      ],
    );
  }
}

class _SystemIcon extends StatelessWidget {
  const _SystemIcon({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        for (final top in [size * .25, size * .5, size * .75])
          Positioned(
            left: size * .16,
            right: size * .16,
            top: top,
            child: Container(height: AppHeight.h1, color: AppColors.notificationSystem),
          ),
        Positioned(left: size * .3, top: size * .18, child: _SystemDot(size: size * .16)),
        Positioned(right: size * .25, top: size * .43, child: _SystemDot(size: size * .16)),
        Positioned(left: size * .43, top: size * .68, child: _SystemDot(size: size * .16)),
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
  const _OrdersIcon({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Positioned(top: size * .24, child: _GiftBox(width: size * .7, height: size * .55)),
        Positioned(
          right: size * .06,
          bottom: size * .11,
          child: Container(
            width: size * .32,
            height: size * .32,
            decoration: const BoxDecoration(color: AppColors.notificationSuccess, shape: BoxShape.circle),
            child: Icon(Icons.check, color: AppColors.white, size: size * .22),
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
              width: width * .85,
              height: height * .72,
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
              height: height * .34,
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
  const _OthersIcon({required this.size});

  final double size;

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
