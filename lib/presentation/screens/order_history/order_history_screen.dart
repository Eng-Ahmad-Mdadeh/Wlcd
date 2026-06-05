import 'package:flutter/material.dart';
import 'package:wlcd/core/extension/localization_extension.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/notifications/widgets/notifications_home_indicator.dart';
import 'package:wlcd/presentation/screens/order_history/widgets/order_history_data.dart';
import 'package:wlcd/presentation/screens/order_history/widgets/order_history_list.dart';
import 'package:wlcd/presentation/screens/order_history/widgets/order_history_tabs.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.orderBackground,
      appBar: CustomAppBar(
        title: context.loc.order_history,
        centerTitle: true,
        showBackButton: true,
        backgroundColor: AppColors.orderBackground,
        // customActions: [
        //   Padding(
        //     padding: EdgeInsetsDirectional.only(end: AppPaddingWidth.p17),
        //     child: IconButton(
        //       onPressed: () {},
        //       padding: EdgeInsets.zero,
        //       constraints: BoxConstraints.tight(Size(AppWidth.w33, AppHeight.h33)),
        //       icon: Icon(Icons.more_vert, color: AppColors.orderTitle, size: AppSize.s23),
        //     ),
        //   ),
        // ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: AppWidth.w428),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p25),
                child: const OrderHistoryTabs(),
              ),
              Expanded(child: OrderHistoryList(orders: orderHistoryItems(context))),
              const NotificationsHomeIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
