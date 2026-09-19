import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';
import 'package:wlcd/presentation/bloc/course_details/get_rating_summary/get_rating_summary_bloc.dart';
import 'package:wlcd/presentation/bloc/course_details/list_reviews/list_reviews_bloc.dart';
import 'package:wlcd/presentation/widgets/loading_widget.dart';
import 'package:wlcd/presentation/widgets/retry_widget.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class ReviewsTab extends StatelessWidget {
  const ReviewsTab({super.key, required this.entity});

  final CourseDetailsEntity entity;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetRatingSummaryBloc()..add(LoadGetRatingSummaryEvent(entity))),
        BlocProvider(create: (_) => ListReviewsBloc()..add(LoadListReviewsEvent(entity))),
      ],
      child: _ReviewsView(entity: entity),
    );
  }
}

class _ReviewsView extends StatelessWidget {
  const _ReviewsView({required this.entity});

  final CourseDetailsEntity entity;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<GetRatingSummaryBloc>().add(LoadGetRatingSummaryEvent(entity));
        context.read<ListReviewsBloc>().add(LoadListReviewsEvent(entity));
      },
      child: ListView(
        key: const PageStorageKey('reviews-tab-scroll'),
        padding: EdgeInsets.fromLTRB(AppPaddingWidth.p18, 0, AppPaddingWidth.p18, AppPaddingHeight.p90),
        children: [
          const SectionTitle(text: 'Ratings', fontSize: 18, color: AppColors.searchCardTitle),
          SizedBox(height: AppHeight.h12),
          BlocBuilder<GetRatingSummaryBloc, IGetRatingSummaryState>(
            builder: (context, state) {
              if (state is GetRatingSummaryFailed) {
                return RetryWidget(
                  showText: false,
                  onReload: () => context.read<GetRatingSummaryBloc>().add(LoadGetRatingSummaryEvent(entity)),
                );
              }
              if (state is! GetRatingSummaryLoaded) return const LoadingWidget(0, size: 36);
              final json = state.getRatingSummary?.value ?? const <String, dynamic>{};
              final rating = json['averageRating'] ?? json['average'] ?? json['rating'] ?? '—';
              final count = json['reviewCount'] ?? json['total'] ?? json['count'];
              return _RatingCard(rating: rating.toString(), count: count?.toString());
            },
          ),
          SizedBox(height: AppHeight.h18),
          const SectionTitle(text: 'User reviews', fontSize: 18, color: AppColors.searchCardTitle),
          SizedBox(height: AppHeight.h10),
          BlocBuilder<ListReviewsBloc, IListReviewsState>(
            builder: (context, state) {
              if (state is ListReviewsFailed) {
                return RetryWidget(
                  onReload: () => context.read<ListReviewsBloc>().add(LoadListReviewsEvent(entity)),
                );
              }
              if (state is! ListReviewsLoaded) return const LoadingWidget(0);
              final json = state.listReviews?.value ?? const <String, dynamic>{};
              final reviews = _items(json, const ['items', 'reviews', 'data']);
              if (reviews.isEmpty) {
                return const BodyTitle(text: 'No reviews yet.', fontSize: 13, color: AppColors.searchRatingText);
              }
              return Column(
                children: [
                  for (final review in reviews) ...[
                    _ReviewCard(review: review),
                    SizedBox(height: AppHeight.h10),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
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
    final author = review['authorName'] ?? review['userName'] ?? review['author'] ?? 'Learner';
    final comment = review['comment'] ?? review['content'] ?? review['text'] ?? '';
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
          BodyTitle(text: author.toString(), fontSize: 14, color: AppColors.searchCardTitle),
          if (rating != null) BodyTitle(text: '★ $rating', fontSize: 12, color: AppColors.searchRatingText),
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

List<Map<String, dynamic>> _items(Map<String, dynamic> json, List<String> keys) {
  for (final key in keys) {
    final value = json[key];
    if (value is List) return value.whereType<Map>().map((item) => Map<String, dynamic>.from(item)).toList();
  }
  return const [];
}
