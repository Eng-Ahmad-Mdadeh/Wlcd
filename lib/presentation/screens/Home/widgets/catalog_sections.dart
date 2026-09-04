import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/extension/localization_extension.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/data/model/catalog/course/course_model.dart';
import 'package:wlcd/presentation/bloc/catalog/categories/categories_bloc.dart';
import 'package:wlcd/presentation/bloc/catalog/featured_courses/featured_courses_bloc.dart';
import 'package:wlcd/presentation/bloc/catalog/recommended_courses/recommended_courses_bloc.dart';
import 'package:wlcd/presentation/cubit/catalog/featured_courses_query_cubit.dart';
import 'package:wlcd/presentation/screens/Home/widgets/section_header.dart';
import 'package:wlcd/presentation/widgets/course/courses_grid.dart';
import 'package:wlcd/presentation/widgets/loading_widget.dart';
import 'package:wlcd/presentation/widgets/retry_widget.dart';

class HomeCategoriesSection extends StatelessWidget {
  const HomeCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeaderRow(title: context.loc.home_categories),
        SizedBox(height: AppHeight.h14),
        BlocBuilder<CategoriesBloc, ICategoriesState>(
          builder: (context, state) {
            if (state is CategoriesFailed) {
              return _CatalogRetry(onRetry: () => context.read<CategoriesBloc>().add(const LoadCategoriesEvent()));
            }
            if (state is CategoriesLoaded) {
              final categories = state.categories?.categories ?? const [];
              if (categories.isEmpty) return const SizedBox.shrink();
              return SizedBox(
                height: AppHeight.h45,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => SizedBox(width: AppWidth.w8),
                  itemBuilder: (_, index) => Chip(
                    label: Text(categories[index].label),
                    backgroundColor: AppColors.white,
                    side: const BorderSide(color: AppColors.searchCardBorder),
                  ),
                ),
              );
            }
            return const _CatalogLoading();
          },
        ),
      ],
    );
  }
}

class HomeFeaturedCoursesSection extends StatelessWidget {
  const HomeFeaturedCoursesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeaderRow(title: context.loc.home_featured_courses),
        SizedBox(height: AppHeight.h14),
        BlocBuilder<FeaturedCoursesBloc, IFeaturedCoursesState>(
          builder: (context, state) {
            if (state is FeaturedCoursesFailed) {
              return _CatalogRetry(
                onRetry: () => context.read<FeaturedCoursesBloc>().add(
                  LoadFeaturedCoursesEvent(context.read<FeaturedCoursesQueryCubit>().state),
                ),
              );
            }
            if (state is FeaturedCoursesLoaded) {
              return CoursesGrid(courses: _toCourseData(state.courses?.data));
            }
            return const _CatalogLoading();
          },
        ),
      ],
    );
  }
}

class HomeRecommendedCoursesSection extends StatelessWidget {
  const HomeRecommendedCoursesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeaderRow(title: context.loc.home_recommended_courses),
        SizedBox(height: AppHeight.h14),
        BlocBuilder<RecommendedCoursesBloc, IRecommendedCoursesState>(
          builder: (context, state) {
            if (state is RecommendedCoursesFailed) {
              return _CatalogRetry(
                onRetry: () => context.read<RecommendedCoursesBloc>().add(const LoadRecommendedCoursesEvent()),
              );
            }
            if (state is RecommendedCoursesLoaded) {
              return CoursesGrid(courses: _toCourseData(state.courses?.data));
            }
            return const _CatalogLoading();
          },
        ),
      ],
    );
  }
}

List<CourseData> _toCourseData(List<CourseModel>? courses) => [
  for (final course in courses ?? const <CourseModel>[])
    CourseData(
      category: course.primaryCategoryLabel ?? '',
      title: course.title ?? '',
      price: course.price?.displayLabel ?? '',
      duration: _formatDuration(course.estimatedDurationSeconds ?? 0),
      posterType: CoursePosterType.dark,
      imageUrl: course.thumbnail?.url ?? '',
    ),
];

String _formatDuration(int totalSeconds) {
  final hours = totalSeconds ~/ Duration.secondsPerHour;
  final minutes = (totalSeconds % Duration.secondsPerHour) ~/ 60;
  return '${hours}h ${minutes.toString().padLeft(2, '0')}m';
}

class _CatalogLoading extends StatelessWidget {
  const _CatalogLoading();

  @override
  Widget build(BuildContext context) => SizedBox(height: AppHeight.h130, child: const LoadingWidget(0));
}

class _CatalogRetry extends StatelessWidget {
  const _CatalogRetry({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: AppHeight.h100,
    child: RetryWidget(onReload: onRetry),
  );
}
