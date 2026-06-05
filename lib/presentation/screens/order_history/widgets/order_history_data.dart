import 'package:flutter/material.dart';
import 'package:wlcd/core/extension/localization_extension.dart';
import 'package:wlcd/core/resources/app_colors.dart';

enum OrderHistoryStatus { pending, successful, canceled }

class OrderHistoryItemData {
  const OrderHistoryItemData({
    required this.category,
    required this.title,
    required this.price,
    required this.rating,
    required this.ratingCount,
    required this.date,
    required this.status,
    required this.imageUrl,
  });

  final String category;
  final String title;
  final String price;
  final double rating;
  final String ratingCount;
  final String date;
  final OrderHistoryStatus status;
  final String imageUrl;
}

extension OrderHistoryStatusUi on OrderHistoryStatus {
  String label(BuildContext context) => switch (this) {
    OrderHistoryStatus.pending => context.loc.order_status_pending,
    OrderHistoryStatus.successful => context.loc.order_status_successful,
    OrderHistoryStatus.canceled => context.loc.order_status_canceled,
  };

  Color get color => switch (this) {
    OrderHistoryStatus.pending => AppColors.orderPending,
    OrderHistoryStatus.successful => AppColors.orderSuccessful,
    OrderHistoryStatus.canceled => AppColors.orderCanceled,
  };
}

List<OrderHistoryItemData> orderHistoryItems(BuildContext context) => [
  OrderHistoryItemData(
    category: context.loc.ux_design,
    title: context.loc.order_course_title_hooked,
    price: r'$98.00',
    rating: 4.7,
    ratingCount: '(11,021)',
    date: context.loc.order_date_first,
    status: OrderHistoryStatus.pending,
    imageUrl: 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=400&auto=format&fit=crop',
  ),
  OrderHistoryItemData(
    category: context.loc.ux_design,
    title: context.loc.order_course_title_web_design,
    price: r'$98.00',
    rating: 4.7,
    ratingCount: '(11,021)',
    date: context.loc.order_date_second,
    status: OrderHistoryStatus.successful,
    imageUrl: 'https://images.unsplash.com/photo-1515378791036-0648a3ef77b2?w=400&auto=format&fit=crop',
  ),
  OrderHistoryItemData(
    category: context.loc.ux_design,
    title: context.loc.order_course_title_cfo,
    price: r'$189.99',
    rating: 4.0,
    ratingCount: '(21,765)',
    date: context.loc.order_date_third,
    status: OrderHistoryStatus.canceled,
    imageUrl: 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=400&auto=format&fit=crop',
  ),
];
