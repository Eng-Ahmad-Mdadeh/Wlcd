import 'package:flutter/material.dart';
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
  String get label => switch (this) {
    OrderHistoryStatus.pending => 'Pending',
    OrderHistoryStatus.successful => 'Successful',
    OrderHistoryStatus.canceled => 'Canceled',
  };

  Color get color => switch (this) {
    OrderHistoryStatus.pending => AppColors.orderPending,
    OrderHistoryStatus.successful => AppColors.orderSuccessful,
    OrderHistoryStatus.canceled => AppColors.orderCanceled,
  };
}

const List<OrderHistoryItemData> orderHistoryItems = [
  OrderHistoryItemData(
    category: 'UX Design',
    title: 'Hooked: How to Build Habit Forming Products',
    price: r'$98.00',
    rating: 4.7,
    ratingCount: '(11,021)',
    date: 'Jan 28, 2023 04:00 PM',
    status: OrderHistoryStatus.pending,
    imageUrl: 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=400&auto=format&fit=crop',
  ),
  OrderHistoryItemData(
    category: 'UX Design',
    title: 'Complete Web Design from Figma to Webflow',
    price: r'$98.00',
    rating: 4.7,
    ratingCount: '(11,021)',
    date: 'Jan 24, 2023 04:00 PM',
    status: OrderHistoryStatus.successful,
    imageUrl: 'https://images.unsplash.com/photo-1515378791036-0648a3ef77b2?w=400&auto=format&fit=crop',
  ),
  OrderHistoryItemData(
    category: 'UX Design',
    title: 'Chief Financial Officer Leadership Program',
    price: r'$189.99',
    rating: 4.0,
    ratingCount: '(21,765)',
    date: 'Jan 10, 2023 03:15 AM',
    status: OrderHistoryStatus.canceled,
    imageUrl: 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=400&auto=format&fit=crop',
  ),
];
