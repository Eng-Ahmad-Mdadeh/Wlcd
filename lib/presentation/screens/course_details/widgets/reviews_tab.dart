import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';
import 'package:wlcd/data/model/course_details/course_reviews_tab/course_reviews_tab_model.dart';

class ReviewsTab extends StatelessWidget {
  const ReviewsTab({super.key, required this.reviews});
  final CourseReviewsTabModel? reviews;

  @override
  Widget build(BuildContext context) {
    final data = reviews;
    return ListView(
      key: const PageStorageKey('reviews-tab-scroll'),
      padding: EdgeInsets.fromLTRB(
        AppPaddingWidth.p18,
        0,
        AppPaddingWidth.p18,
        AppPaddingHeight.p90,
      ),
      children: [
        const SectionTitle(
          text: 'Ratings',
          fontSize: 18,
          color: AppColors.searchCardTitle,
        ),
        if (data == null || !data.accessible)
          const BodyTitle(text: 'Reviews are not available.', fontSize: 13)
        else ...[
          ListTile(
            title: Text('★ ${data.ratingAverage ?? '—'}'),
            subtitle: Text('${data.reviewCount} customer reviews'),
          ),
          const SectionTitle(
            text: 'User reviews',
            fontSize: 18,
            color: AppColors.searchCardTitle,
          ),
          if (data.data.isEmpty)
            const BodyTitle(text: 'No reviews yet.', fontSize: 13),
          for (final review in data.data)
            Card(
              child: Padding(
                padding: EdgeInsets.all(AppPaddingWidth.p14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('★ ${review.rating}'),
                    if (review.reviewText != null) Text(review.reviewText!),
                    if (review.publishedAt != null)
                      Text(
                        review.publishedAt!
                            .toLocal()
                            .toString()
                            .split(' ')
                            .first,
                      ),
                  ],
                ),
              ),
            ),
        ],
      ],
    );
  }
}
