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
  Widget build(BuildContext context) => ListView(
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
      SizedBox(height: AppHeight.h12),
      if (reviews?.accessible == true)
        _RatingCard(
          rating: reviews!.ratingAverage?.toString() ?? '—',
          count: reviews!.reviewCount.toString(),
        ),
      SizedBox(height: AppHeight.h18),
      const SectionTitle(
        text: 'User reviews',
        fontSize: 18,
        color: AppColors.searchCardTitle,
      ),
      SizedBox(height: AppHeight.h10),
      if (reviews?.accessible != true)
        const BodyTitle(
          text: 'Reviews are not available.',
          fontSize: 13,
          color: AppColors.searchRatingText,
        )
      else if (reviews!.data.isEmpty)
        const BodyTitle(
          text: 'No reviews yet.',
          fontSize: 13,
          color: AppColors.searchRatingText,
        )
      else
        Column(
          children: [
            for (final review in reviews!.data) ...[
              _ReviewCard(
                review: {
                  'rating': review.rating,
                  'comment': review.reviewText ?? '',
                },
              ),
              SizedBox(height: AppHeight.h10),
            ],
          ],
        ),
    ],
  );
}

class _RatingCard extends StatelessWidget {
  const _RatingCard({required this.rating, this.count});
  final String rating;
  final String? count;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: EdgeInsets.all(AppPaddingWidth.p16),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.searchCardBorder),
      borderRadius: BorderRadius.circular(AppRadius.r14),
    ),
    child: Column(
      children: [
        BodyTitle(text: rating, fontSize: 26, color: AppColors.searchCardTitle),
        SizedBox(height: AppHeight.h8),
        BodyTitle(
          text: count == null ? 'Customer rating' : '$count customer reviews',
          fontSize: 13,
          color: AppColors.searchRatingText,
        ),
      ],
    ),
  );
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review});
  final Map<String, dynamic> review;

  @override
  Widget build(BuildContext context) {
    final author =
        review['authorName'] ??
        review['userName'] ??
        review['author'] ??
        'Learner';
    final comment =
        review['comment'] ?? review['content'] ?? review['text'] ?? '';
    final rating = review['rating'];
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppPaddingWidth.p14),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.searchCardBorder),
        borderRadius: BorderRadius.circular(AppRadius.r12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BodyTitle(
            text: author.toString(),
            fontSize: 14,
            color: AppColors.searchCardTitle,
          ),
          if (rating != null)
            BodyTitle(
              text: '★ $rating',
              fontSize: 12,
              color: AppColors.searchRatingText,
            ),
          if (comment.toString().isNotEmpty) ...[
            SizedBox(height: AppHeight.h8),
            BodyTitle(
              text: comment.toString(),
              fontSize: 13,
              color: AppColors.searchRatingText,
              overflow: TextOverflow.visible,
            ),
          ],
        ],
      ),
    );
  }
}
