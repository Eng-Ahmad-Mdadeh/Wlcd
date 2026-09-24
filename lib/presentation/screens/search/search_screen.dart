import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/core/routes/app_routes.dart';
import 'package:wlcd/data/model/catalog/course/course_model.dart';
import 'package:wlcd/domain/entity/catalog/get_courses_entity.dart';
import 'package:wlcd/presentation/bloc/catalog/courses/courses_bloc.dart';
import 'package:wlcd/presentation/screens/search/widgets/filter_row.dart';
import 'package:wlcd/presentation/screens/search/widgets/result_header.dart';
import 'package:wlcd/presentation/screens/search/widgets/search_header.dart';
import 'package:wlcd/presentation/widgets/course/course_card.dart';
import 'package:wlcd/presentation/widgets/loading_widget.dart';
import 'package:wlcd/presentation/widgets/no_result_widget.dart';
import 'package:wlcd/presentation/widgets/retry_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CoursesBloc()..add(const LoadCoursesEvent(GetCoursesEntity(limit: 10))),
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

  void _reload() {
    context.read<CoursesBloc>().add(LoadCoursesEvent(_query));
  }

  Future<void> _refresh() async {
    final bloc = context.read<CoursesBloc>();
    bloc.add(LoadCoursesEvent(_query));
    await bloc.stream.firstWhere((state) => state is! CoursesLoading);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: BlocBuilder<CoursesBloc, ICoursesState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: _refresh,
              child: CustomScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SearchControlsDelegate(onSubmitted: _search, onClose: () => Navigator.maybePop(context)),
                  ),
                  ..._resultSlivers(state),
                  SliverToBoxAdapter(child: SizedBox(height: AppHeight.h30)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _resultSlivers(ICoursesState state) {
    if (state is CoursesFailed) {
      return [SliverFillRemaining(hasScrollBody: false, child: RetryWidget(onReload: _reload))];
    }

    if (state is! CoursesLoaded) {
      return const [SliverFillRemaining(hasScrollBody: false, child: LoadingWidget(0))];
    }

    final courses = state.courses?.data ?? const <CourseModel>[];
    return [
      SliverPadding(
        padding: EdgeInsetsDirectional.fromSTEB(
          AppPaddingWidth.p18,
          AppPaddingHeight.p18,
          AppPaddingWidth.p18,
          AppPaddingHeight.p12,
        ),
        sliver: SliverToBoxAdapter(child: ResultHeader(resultCount: courses.length)),
      ),
      if (courses.isEmpty)
        const SliverFillRemaining(hasScrollBody: false, child: NoResultWidget(title: 'No courses found'))
      else
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p18),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              if (index.isOdd) return SizedBox(height: AppHeight.h14);
              return _CourseResult(course: courses[index ~/ 2]);
            }, childCount: courses.length * 2 - 1),
          ),
        ),
    ];
  }
}

class _SearchControlsDelegate extends SliverPersistentHeaderDelegate {
  const _SearchControlsDelegate({required this.onSubmitted, required this.onClose});

  final ValueChanged<String> onSubmitted;
  final VoidCallback onClose;

  @override
  double get minExtent => AppHeight.h120;

  @override
  double get maxExtent => AppHeight.h120;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: overlapsContent
            ? const [BoxShadow(color: AppColors.greySec, blurRadius: 8, offset: Offset(0, 3))]
            : null,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
          AppPaddingWidth.p18,
          AppPaddingHeight.p8,
          AppPaddingWidth.p18,
          AppPaddingHeight.p8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SearchHeader(onSubmitted: onSubmitted, onClose: onClose),
            const FilterRow(),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _SearchControlsDelegate oldDelegate) =>
      oldDelegate.onSubmitted != onSubmitted || oldDelegate.onClose != onClose;
}

class _CourseResult extends StatelessWidget {
  const _CourseResult({required this.course});

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return CourseCard(
      onTap: course.courseId == null ? null : () => CourseDetailsRoute(courseId: course.courseId!).push(context),
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
