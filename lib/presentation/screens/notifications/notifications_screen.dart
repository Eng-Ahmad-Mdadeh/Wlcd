import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';

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
      backgroundColor: const Color(0xFFF8F8F8),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 428.w),
          child: Column(
            children: [
              const _NotificationsHeader(),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.fromLTRB(39.w, 17.h, 39.w, 22.h),
                  physics: const BouncingScrollPhysics(),
                  itemCount: _notifications.length,
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemBuilder: (context, index) {
                    return _NotificationCard(notification: _notifications[index]);
                  },
                ),
              ),
              const _HomeIndicator(),
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
      height: 228.h,
      color: AppColors.white,
      padding: EdgeInsets.fromLTRB(38.w, 14.h, 38.w, 0),
      child: Column(
        children: [
          const _StatusBar(),
          SizedBox(height: 31.h),
          _TopBar(
            onBackPressed: () {
              if (context.canPop()) {
                context.pop();
              }
            },
          ),
          SizedBox(height: 33.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: NotificationsScreen._filters.map((filter) => _FilterButton(filter: filter)).toList(),
          ),
        ],
      ),
    );
  }
}

class _StatusBar extends StatelessWidget {
  const _StatusBar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 18.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '9:41',
            style: TextStyle(
              color: const Color(0xFF111827),
              fontFamily: AppFontFamily.rubik,
              fontSize: 15.sp,
              fontWeight: AppFontWeight.medium,
              height: 1,
            ),
          ),
          Row(
            children: [
              Icon(Icons.signal_cellular_alt, color: const Color(0xFF111827), size: 17.r),
              SizedBox(width: 4.w),
              Icon(Icons.wifi, color: const Color(0xFF111827), size: 16.r),
              SizedBox(width: 4.w),
              Icon(Icons.battery_full, color: const Color(0xFF111827), size: 22.r),
            ],
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
      height: 24.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: IconButton(
              onPressed: onBackPressed,
              padding: EdgeInsets.zero,
              constraints: BoxConstraints.tight(Size(28.r, 28.r)),
              icon: Icon(Icons.arrow_back, color: const Color(0xFF111827), size: 23.r),
            ),
          ),
          Text(
            'Notifications',
            style: TextStyle(
              color: const Color(0xFF111827),
              fontFamily: AppFontFamily.rubik,
              fontSize: 16.sp,
              fontWeight: AppFontWeight.bold,
              letterSpacing: -0.2,
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: IconButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              constraints: BoxConstraints.tight(Size(28.r, 28.r)),
              icon: Icon(Icons.more_vert, color: const Color(0xFF111827), size: 23.r),
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
      width: 58.w,
      child: Column(
        children: [
          Container(
            width: 48.r,
            height: 48.r,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFEFF1F5), width: 1.w),
            ),
            child: Center(child: _NotificationTypeIcon(type: filter.type, size: 24.r)),
          ),
          SizedBox(height: 12.h),
          Text(
            filter.label,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF6F7787),
              fontFamily: AppFontFamily.rubik,
              fontSize: 11.sp,
              fontWeight: AppFontWeight.regular,
              height: 1,
            ),
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
      constraints: BoxConstraints(minHeight: 160.h),
      padding: EdgeInsets.fromLTRB(16.w, 17.h, 17.w, 17.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38.r,
            height: 38.r,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFEFF1F5), width: 1.w),
            ),
            child: Center(child: _NotificationTypeIcon(type: notification.type, size: 20.r)),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color(0xFF111827),
                    fontFamily: AppFontFamily.rubik,
                    fontSize: 13.sp,
                    fontWeight: AppFontWeight.bold,
                    height: 1.16,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  notification.category,
                  style: TextStyle(
                    color: const Color(0xFF7C8495),
                    fontFamily: AppFontFamily.rubik,
                    fontSize: 11.sp,
                    fontWeight: AppFontWeight.regular,
                    height: 1,
                  ),
                ),
                SizedBox(height: 15.h),
                Text(
                  notification.description,
                  style: TextStyle(
                    color: const Color(0xFF5F6676),
                    fontFamily: AppFontFamily.rubik,
                    fontSize: 11.sp,
                    fontWeight: AppFontWeight.regular,
                    height: 1.45,
                    letterSpacing: 0.05,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  notification.date,
                  style: TextStyle(
                    color: const Color(0xFFA1A9B8),
                    fontFamily: AppFontFamily.rubik,
                    fontSize: 11.sp,
                    fontWeight: AppFontWeight.regular,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
          decoration: BoxDecoration(color: const Color(0xFFFFC547), borderRadius: BorderRadius.circular(size * .08)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, color: AppColors.white, size: size * .22),
            SizedBox(width: size * .18),
            Icon(Icons.star, color: AppColors.white, size: size * .22),
          ],
        ),
        Positioned(
          left: size * .35,
          top: size * .27,
          bottom: size * .22,
          child: Container(width: size * .05, color: const Color(0xFFFFD96E)),
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
    final blue = const Color(0xFF1684FC);
    return Stack(
      alignment: Alignment.center,
      children: [
        for (final top in [size * .25, size * .5, size * .75])
          Positioned(
            left: size * .16,
            right: size * .16,
            top: top,
            child: Container(height: 1.2, color: blue),
          ),
        Positioned(left: size * .3, top: size * .18, child: _SystemDot(size: size * .16, color: blue)),
        Positioned(right: size * .25, top: size * .43, child: _SystemDot(size: size * .16, color: blue)),
        Positioned(left: size * .43, top: size * .68, child: _SystemDot(size: size * .16, color: blue)),
      ],
    );
  }
}

class _SystemDot extends StatelessWidget {
  const _SystemDot({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 1.2),
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
            decoration: const BoxDecoration(color: Color(0xFF20C77B), shape: BoxShape.circle),
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
              decoration: BoxDecoration(color: const Color(0xFFFFA800), borderRadius: BorderRadius.circular(width * .07)),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: width,
              height: height * .34,
              decoration: BoxDecoration(color: const Color(0xFFFFC02E), borderRadius: BorderRadius.circular(width * .07)),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            child: Container(width: width * .14, color: const Color(0xFFFF7A00)),
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
    final blue = const Color(0xFF3C7CFF);
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(size * .17),
      mainAxisSpacing: size * .1,
      crossAxisSpacing: size * .1,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        4,
        (_) => Container(decoration: BoxDecoration(color: blue, borderRadius: BorderRadius.circular(size * .06))),
      ),
    );
  }
}

class _HomeIndicator extends StatelessWidget {
  const _HomeIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 23.h,
      alignment: Alignment.topCenter,
      color: const Color(0xFFF8F8F8),
      child: Container(
        width: 134.w,
        height: 5.h,
        decoration: BoxDecoration(color: const Color(0xFF111827), borderRadius: BorderRadius.circular(100.r)),
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
