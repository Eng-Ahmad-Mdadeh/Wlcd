import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/data/model/course_details/course_details_model.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';
import 'package:wlcd/presentation/bloc/course_details/get_course_details/get_course_details_bloc.dart';
import 'package:wlcd/presentation/widgets/image_view.dart';
import 'package:wlcd/presentation/widgets/loading_widget.dart';
import 'package:wlcd/presentation/widgets/retry_widget.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

import 'widgets/about_tab.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({super.key, required this.courseId});

  final String courseId;

  @override
  Widget build(BuildContext context) {
    final entity = CourseDetailsEntity(courseId: courseId);
    return BlocProvider(
      create: (_) => GetCourseDetailsBloc()..add(LoadGetCourseDetailsEvent(entity)),
      child: _CourseDetailsBody(entity: entity),
    );
  }
}

class _CourseDetailsBody extends StatelessWidget {
  const _CourseDetailsBody({required this.entity});

  final CourseDetailsEntity entity;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCourseDetailsBloc, IGetCourseDetailsState>(
      builder: (context, state) {
        if (state is GetCourseDetailsFailed) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: RetryWidget(
              onReload: () => context.read<GetCourseDetailsBloc>().add(LoadGetCourseDetailsEvent(entity)),
            ),
          );
        }
        if (state is! GetCourseDetailsLoaded || state.getCourseDetails == null) {
          return const Scaffold(backgroundColor: AppColors.white, body: LoadingWidget(0));
        }
        return _buildDetails(context, state.getCourseDetails!);
      },
    );
  }

  Widget _buildDetails(BuildContext context, CourseDetailsModel course) {
    final thumbnailUrl = course.thumbnail?['url']?.toString();
    final availableTabs = _buildAvailableTabs(course);
    return DefaultTabController(
      length: availableTabs.length,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: NestedScrollView(
            physics: NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 290,
                  backgroundColor: AppColors.white,
                  surfaceTintColor: Colors.transparent,
                  pinned: true,
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back, color: AppColors.black),
                  ),
                  actions: const [
                    Icon(Icons.ios_share_outlined, color: AppColors.black, size: 20),
                    SizedBox(width: 12),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Padding(
                      padding: EdgeInsets.fromLTRB(
                        AppPaddingWidth.p18,
                        AppPaddingHeight.p55,
                        AppPaddingWidth.p18,
                        AppPaddingHeight.p10,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadius.r14),
                        child: ImageView(
                          imagePath: thumbnailUrl ?? '',
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p18),
                    child: Column(
                      children: [
                        SizedBox(height: AppHeight.h14),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppPaddingWidth.p8,
                                vertical: AppPaddingHeight.p4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.searchTagBackground,
                                borderRadius: BorderRadius.circular(AppRadius.r8),
                              ),
                              child: BodyTitle(
                                text: course.language ?? '',
                                fontSize: 10,
                                color: AppColors.searchTagText,
                              ),
                            ),
                            const Spacer(),
                            BodyTitle(
                              text: _formatDuration(course.estimatedDurationSeconds),
                              fontSize: 12,
                              color: AppColors.searchRatingText,
                            ),
                            SizedBox(width: AppWidth.w8),
                            BodyTitle(text: course.difficulty, fontSize: 12, color: AppColors.searchCardTitle),
                          ],
                        ),
                        SizedBox(height: AppHeight.h10),
                        SectionTitle(
                          text: course.title,
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: AppColors.searchCardTitle,
                          height: 1.3,
                        ),
                        SizedBox(height: AppHeight.h16),
                      ],
                    ),
                  ),
                ),
                SliverAppBar(
                  pinned: true,
                  toolbarHeight: 0,

                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(65),
                    child: Container(
                      color: AppColors.white,
                      padding: EdgeInsets.fromLTRB(AppPaddingWidth.p18, 0, AppPaddingWidth.p18, AppPaddingHeight.p12),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(AppRadius.r12),
                        ),
                        child: TabBar(
                          tabs: [for (final item in availableTabs) item.tab],
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          dividerColor: Colors.transparent,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(AppRadius.r8),
                          ),
                          labelColor: AppColors.white,
                          unselectedLabelColor: AppColors.searchRatingText,
                          labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                          unselectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                          padding: EdgeInsets.all(AppPaddingWidth.p4),
                          labelPadding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p12),
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [for (final item in availableTabs) item.page],
            ),
          ),
        ),
      ),
    );
  }

  List<_CourseDetailsTab> _buildAvailableTabs(CourseDetailsModel course) {
    final tabs = <_CourseDetailsTab>[];
    for (final availableTab in course.availableTabs) {
      // The current contract only proves the `overview` projection used by
      // the model fixture. Other values stay opaque until the generated
      // OpenAPI model defines their structure and enum values.
      if (availableTab case {'type': 'overview'}) {
        tabs.add(
          _CourseDetailsTab(
            tab: const Tab(text: 'About'),
            page: AboutTab(description: course.description),
          ),
        );
      }
    }

    // The course description is part of the documented discovery response,
    // so it is the only safe fallback when no typed tab projection is known.
    if (tabs.isEmpty) {
      tabs.add(
        _CourseDetailsTab(
          tab: const Tab(text: 'About'),
          page: AboutTab(description: course.description),
        ),
      );
    }
    return tabs;
  }
}

class _CourseDetailsTab {
  const _CourseDetailsTab({required this.tab, required this.page});

  final Tab tab;
  final Widget page;
}

String _formatDuration(int? totalSeconds) {
  if (totalSeconds == null || totalSeconds <= 0) return '—';
  final hours = totalSeconds ~/ Duration.secondsPerHour;
  final minutes = (totalSeconds % Duration.secondsPerHour) ~/ Duration.secondsPerMinute;
  if (hours == 0) return '${minutes}m';
  return '${hours}h ${minutes.toString().padLeft(2, '0')}m';
}
