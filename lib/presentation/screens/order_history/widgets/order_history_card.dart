import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/order_history/widgets/order_history_data.dart';
import 'package:wlcd/presentation/widgets/image_view.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class OrderHistoryCard extends StatelessWidget {
  const OrderHistoryCard({super.key, required this.order});

  final OrderHistoryItemData order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(AppWidth.w16, AppHeight.h16, AppWidth.w16, AppHeight.h13),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.r14),
        border: Border.all(color: AppColors.orderCardBorder),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageView(
                imagePath: order.imageUrl,
                width: AppWidth.w105,
                height: AppHeight.h105,
                fit: BoxFit.cover,
                radius: BorderRadius.circular(AppRadius.r8),
              ),
              SizedBox(width: AppWidth.w13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CategoryBadge(label: order.category),
                    SizedBox(height: AppHeight.h5),
                    SectionTitle(
                      text: order.title,
                      color: AppColors.orderTitle,
                      fontSize: AppFontSize.s14,
                      fontWeight: AppFontWeight.bold,
                      height: AppLineHeight.orderTitle,
                      maxLines: 3,
                    ),
                    SizedBox(height: AppHeight.h5),
                    BodyTitle(
                      text: order.price,
                      color: AppColors.searchPrice,
                      fontSize: AppFontSize.s13,
                      fontWeight: AppFontWeight.bold,
                    ),
                    SizedBox(height: AppHeight.h5),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 14, color: AppColors.searchStar),
                        SizedBox(width: AppWidth.w4),
                        Expanded(
                          child: BodyTitle(
                            text: '${order.rating.toStringAsFixed(1)} ${order.ratingCount}',
                            color: AppColors.searchRatingText,
                            fontSize: AppFontSize.s11,
                            fontWeight: AppFontWeight.regular,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppHeight.h15),
          Divider(height: AppHeight.h1, thickness: AppHeight.h1, color: AppColors.orderDivider),
          SizedBox(height: AppHeight.h13),
          Row(
            children: [
              Expanded(
                child: BodyTitle(
                  text: order.date,
                  color: AppColors.orderDate,
                  fontSize: AppFontSize.s12,
                  fontWeight: AppFontWeight.regular,
                  maxLines: 1,
                ),
              ),
              BodyTitle(
                text: order.status.label,
                color: order.status.color,
                fontSize: AppFontSize.s12,
                fontWeight: AppFontWeight.medium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  const _CategoryBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppWidth.w7, vertical: AppHeight.h3),
      decoration: BoxDecoration(
        color: AppColors.searchTagBackground,
        borderRadius: BorderRadius.circular(AppRadius.r6),
      ),
      child: BodyTitle(
        text: label,
        color: AppColors.searchTagText,
        fontSize: AppFontSize.s10,
        fontWeight: AppFontWeight.medium,
      ),
    );
  }
}
