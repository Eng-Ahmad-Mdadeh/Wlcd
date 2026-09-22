import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/core/routes/app_routes.dart';
import 'package:wlcd/data/model/catalog/course/course_model.dart';
import 'package:wlcd/domain/entity/catalog/get_courses_entity.dart';
import 'package:wlcd/presentation/bloc/catalog/courses/courses_bloc.dart';
import 'package:wlcd/presentation/widgets/course/course_card.dart';
import 'package:wlcd/presentation/screens/search/widgets/filter_row.dart';
import 'package:wlcd/presentation/screens/search/widgets/result_header.dart';
import 'package:wlcd/presentation/screens/search/widgets/search_header.dart';
import 'package:wlcd/presentation/widgets/loading_widget.dart';
import 'package:wlcd/presentation/widgets/no_result_widget.dart';
import 'package:wlcd/presentation/widgets/retry_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CoursesBloc()
        ..add(const LoadCoursesEvent(GetCoursesEntity())),
      child: const _SearchBody(),
    );
  }
}

class _SearchBody extends StatefulWidget {
  const _SearchBody();

  @override
  State<_SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<_SearchBody> {
  GetCoursesEntity _query = const GetCoursesEntity();

  void _search(String value) {
    _query = GetCoursesEntity(q: value.trim());
    context.read<CoursesBloc>().add(LoadCoursesEvent(_query));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p18, vertical: AppPaddingHeight.p8),
                children: [
                  SizedBox(height: 8),
                  SearchHeader(onSubmitted: _search),
                  SizedBox(height: 12),
                  FilterRow(),
                  SizedBox(height: 18),
                  BlocBuilder<CoursesBloc, ICoursesState>(
                    builder: (context, state) {
                      if (state is CoursesFailed) {
                        return SizedBox(
                          height: AppHeight.h300,
                          child: RetryWidget(
                            onReload: () => context.read<CoursesBloc>().add(
                              LoadCoursesEvent(_query),
                            ),
                          ),
                        );
                      }
                      if (state is! CoursesLoaded) {
                        return SizedBox(
                          height: AppHeight.h300,
                          child: const LoadingWidget(0),
                        );
                      }

                      final courses = state.courses?.data ?? const [];
                      return Column(
                        children: [
                          ResultHeader(resultCount: courses.length),
                          SizedBox(height: AppHeight.h12),
                          if (courses.isEmpty)
                            const NoResultWidget(title: 'No courses found')
                          else
                            for (var index = 0; index < courses.length; index++) ...[
                              _CourseResult(course: courses[index]),
                              if (index < courses.length - 1)
                                SizedBox(height: AppHeight.h14),
                            ],
                        ],
                      );
                    },
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

class _CourseResult extends StatelessWidget {
  const _CourseResult({required this.course});

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return CourseCard(
      onTap: course.courseId == null
          ? null
          : () => CourseDetailsRoute(courseId: course.courseId!).push(context),
      title: course.title ?? '',
      price: course.price?.displayLabel ?? '',
      ratingCount: '(${course.ratingCount ?? 0})',
      ratingAverage: course.ratingAverage,
      category: course.primaryCategoryLabel,
      imageUrl: course.thumbnail?.url,
      thumbnailColor: AppColors.searchThumbBlue,
    );
  }
}
