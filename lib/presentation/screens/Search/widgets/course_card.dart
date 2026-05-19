import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_assets.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/image_view.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.title,
    required this.price,
    required this.ratingCount,
    required this.thumbnailColor,
    this.onTap,
  });

  final String title;
  final String price;
  final String ratingCount;
  final Color thumbnailColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.r14),
      child: Container(
        padding: EdgeInsets.all(AppPaddingWidth.p10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.r14),
          border: Border.all(color: AppColors.searchCardBorder),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: AppWidth.w110,
              height: AppHeight.h110,
              decoration: BoxDecoration(
                color: thumbnailColor,
                borderRadius: BorderRadius.circular(AppRadius.r10),
              ),
              child: ImageView(
                imagePath: AppAssets.buildingImage,
                radius: BorderRadius.circular(AppRadius.r10),
                fit: BoxFit.cover,
                width: AppWidth.w110,
                height: AppHeight.h110,
              ),
            ),
            SizedBox(width: AppWidth.w10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionTitle(
                    text: title,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.searchCardTitle,
                    maxLines: 3,
                    height: 1.4,
                  ),
                  SizedBox(height: AppHeight.h7),
                  BodyTitle(text: price, fontSize: 14, color: AppColors.searchPrice, fontWeight: FontWeight.w600),
                  SizedBox(height: AppHeight.h4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: AppColors.searchStar),
                      SizedBox(width: AppWidth.w4),
                      BodyTitle(text: '4.8 $ratingCount', fontSize: 12, color: AppColors.searchRatingText),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p7, vertical: AppPaddingHeight.p3),
                        decoration: BoxDecoration(
                          color: AppColors.searchTagBackground,
                          borderRadius: BorderRadius.circular(AppRadius.r6),
                        ),
                        child: const BodyTitle(
                          text: 'UX Design',
                          fontSize: 10,
                          color: AppColors.searchTagText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
