import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/order_history/widgets/order_history_card.dart';
import 'package:wlcd/presentation/screens/order_history/widgets/order_history_data.dart';

class OrderHistoryList extends StatelessWidget {
  const OrderHistoryList({super.key, required this.orders});

  final List<OrderHistoryItemData> orders;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(AppWidth.w25, AppHeight.h18, AppWidth.w25, AppHeight.h22),
      physics: const BouncingScrollPhysics(),
      itemCount: orders.length,
      separatorBuilder: (context, index) => SizedBox(height: AppHeight.h16),
      itemBuilder: (context, index) => OrderHistoryCard(order: orders[index]),
    );
  }
}
