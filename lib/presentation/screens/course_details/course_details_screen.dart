import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/data/model/course_details/course_details_model.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';
import 'package:wlcd/presentation/bloc/course_details/get_access_status/get_access_status_bloc.dart';
import 'package:wlcd/presentation/bloc/course_details/get_course_details/get_course_details_bloc.dart';
import 'package:wlcd/presentation/bloc/course_details/get_enrollment/get_enrollment_bloc.dart';
import 'package:wlcd/presentation/bloc/course_details/get_rating_summary/get_rating_summary_bloc.dart';
import 'package:wlcd/presentation/bloc/course_details/is_favorited/is_favorited_bloc.dart';
import 'package:wlcd/presentation/bloc/course_details/list_reviews/list_reviews_bloc.dart';
import 'package:wlcd/presentation/screens/course_details/widgets/downloaded_tab.dart';
import 'package:wlcd/presentation/screens/course_details/widgets/lessons_tab.dart';
import 'package:wlcd/presentation/screens/course_details/widgets/resources_tab.dart';
import 'package:wlcd/presentation/screens/course_details/widgets/forum_tab.dart';
import 'package:wlcd/presentation/screens/favorites/favorites_store.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetCourseDetailsBloc()..add(LoadGetCourseDetailsEvent(entity))),
        BlocProvider(create: (_) => GetRatingSummaryBloc()..add(LoadGetRatingSummaryEvent(entity))),
        BlocProvider(create: (_) => ListReviewsBloc()..add(LoadListReviewsEvent(entity))),
        BlocProvider(create: (_) => GetEnrollmentBloc()..add(LoadGetEnrollmentEvent(entity))),
        BlocProvider(create: (_) => GetAccessStatusBloc()..add(LoadGetAccessStatusEvent(entity))),
        BlocProvider(create: (_) => IsFavoritedBloc()..add(LoadIsFavoritedEvent(entity))),
      ],
      child: _CourseDetailsBody(entity: entity),
    );
  }
}

class _CourseDetailsBody extends StatelessWidget {
  const _CourseDetailsBody({required this.entity});

  final CourseDetailsEntity entity;

  static const _tabs = [
    Tab(text: 'Lessons'),
    Tab(text: 'About'),
    Tab(text: 'المنتدى'),
    Tab(text: 'Downloaded'),
    Tab(text: 'Resources'),
  ];

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
    final priceLabel = course.price?['displayLabel']?.toString();
    final rating = course.raw['ratingAverage']?.toString() ?? '—';
    final ratingCount = course.raw['ratingCount']?.toString() ?? '0';
    final enrolledCount = course.raw['enrollmentCount']?.toString() ?? '0';
    final lessonCount = course.raw['lessonCount']?.toString() ?? '0';
    final pages = [
      const LessonsTab(),
      AboutTab(description: course.description),
      const ForumTab(),
      const DownloadedTab(),
      const ResourcesTab(),
    ];
    return DefaultTabController(
      length: _tabs.length,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
          bottomNavigationBar: Padding(
            padding: EdgeInsets.fromLTRB(
              AppPaddingWidth.p18,
              AppPaddingHeight.p8,
              AppPaddingWidth.p18,
              AppPaddingHeight.p14,
            ),
            child: Row(
              children: [
                Container(
                  height: AppHeight.h52,
                  width: AppWidth.w52,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.searchCardBorder),
                    borderRadius: BorderRadius.circular(AppRadius.r14),
                  ),
                  child: IconButton(
                    onPressed: () => _showFavoriteGroupsSheet(context),
                    icon: const Icon(Icons.favorite_border, color: AppColors.primary),
                  ),
                ),
                SizedBox(width: AppWidth.w12),
                Expanded(
                  child: SizedBox(
                    height: AppHeight.h52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.r28)),
                      ),
                      onPressed: () {},
                      child: BodyTitle(
                        text: priceLabel == null || priceLabel.isEmpty ? 'Start learning' : 'Buy $priceLabel',
                        color: AppColors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ImageView(
                              imagePath: thumbnailUrl ?? '',
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.white.withValues(alpha: .35),
                              ),
                              child: const Icon(Icons.play_arrow_rounded, color: AppColors.white, size: 30),
                            ),
                          ],
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
                                text: course.raw['primaryCategoryLabel']?.toString() ?? course.language ?? '',
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
                        SizedBox(height: AppHeight.h10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(Icons.star, size: 16, color: AppColors.searchStar),
                            SizedBox(width: AppWidth.w5),
                            BodyTitle(text: '$rating ($ratingCount)', fontSize: 12, color: AppColors.searchRatingText),
                            SizedBox(
                              height: AppHeight.h15,
                              child: const VerticalDivider(color: AppColors.grey),
                            ),
                            BodyTitle(text: '$enrolledCount enrolled', fontSize: 12, color: AppColors.searchRatingText),
                            SizedBox(
                              height: AppHeight.h15,
                              child: const VerticalDivider(color: AppColors.grey),
                            ),
                            BodyTitle(text: '$lessonCount Lessons', fontSize: 12, color: AppColors.searchRatingText),
                          ],
                        ),
                        SizedBox(height: AppHeight.h14),
                        LinearProgressIndicator(
                          minHeight: 6,
                          value: 0.30,
                          borderRadius: BorderRadius.circular(AppRadius.r50),
                          backgroundColor: AppColors.lightGrey,
                          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                        ),
                        SizedBox(height: AppHeight.h8),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: BodyTitle(
                            text: '30% from 24 sessions',
                            fontSize: 12,
                            color: AppColors.searchRatingText,
                          ),
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
                          tabs: _tabs,
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
            body: TabBarView(physics: const NeverScrollableScrollPhysics(), children: pages),
          ),
        ),
      ),
    );
  }
}

String _formatDuration(int? totalSeconds) {
  if (totalSeconds == null || totalSeconds <= 0) return '—';
  final hours = totalSeconds ~/ Duration.secondsPerHour;
  final minutes = (totalSeconds % Duration.secondsPerHour) ~/ Duration.secondsPerMinute;
  if (hours == 0) return '${minutes}m';
  return '${hours}h ${minutes.toString().padLeft(2, '0')}m';
}

void _showFavoriteGroupsSheet(BuildContext context) {
  final groupController = TextEditingController();

  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.r24))),
    builder: (sheetContext) {
      return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
          AppPaddingWidth.p18,
          AppPaddingHeight.p18,
          AppPaddingWidth.p18,
          MediaQuery.of(sheetContext).viewInsets.bottom + AppPaddingHeight.p18,
        ),
        child: ValueListenableBuilder<List<FavoriteGroup>>(
          valueListenable: FavoritesStore.groups,
          builder: (context, groups, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: AppWidth.w45,
                    height: AppHeight.h4,
                    decoration: BoxDecoration(
                      color: AppColors.searchCardBorder,
                      borderRadius: BorderRadius.circular(AppRadius.r10),
                    ),
                  ),
                ),
                SizedBox(height: AppHeight.h18),
                SectionTitle(
                  text: 'إضافة إلى مجموعة',
                  color: AppColors.text,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: AppHeight.h8),
                BodyTitle(
                  text: 'اختر مجموعة موجودة أو أنشئ مجموعة جديدة كما في قوائم Airbnb.',
                  color: AppColors.muted,
                  fontSize: 13,
                  maxLines: 2,
                ),
                SizedBox(height: AppHeight.h18),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: groups.length,
                    separatorBuilder: (_, __) => Divider(color: AppColors.searchCardBorder, height: AppHeight.h18),
                    itemBuilder: (context, index) {
                      final group = groups[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundColor: AppColors.lightPrim,
                          child: const Icon(Icons.folder_rounded, color: AppColors.primary),
                        ),
                        title: SectionTitle(
                          text: group.name,
                          color: AppColors.text,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        subtitle: BodyTitle(
                          text: '${group.courses.length} كورسات',
                          color: AppColors.muted,
                          fontSize: 12,
                        ),
                        onTap: () {
                          FavoritesStore.addCourseToGroup(course: FavoritesStore.demoCourse, groupName: group.name);
                          Navigator.of(sheetContext).pop();
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: AppHeight.h14),
                TextField(
                  controller: groupController,
                  decoration: InputDecoration(
                    hintText: 'اسم مجموعة جديدة',
                    filled: true,
                    fillColor: AppColors.backGround,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.r14),
                      borderSide: const BorderSide(color: AppColors.searchCardBorder),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.r14),
                      borderSide: const BorderSide(color: AppColors.searchCardBorder),
                    ),
                  ),
                ),
                SizedBox(height: AppHeight.h12),
                SizedBox(
                  width: double.infinity,
                  height: AppHeight.h52,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.r28)),
                    ),
                    onPressed: () {
                      FavoritesStore.addCourseToGroup(
                        course: FavoritesStore.demoCourse,
                        groupName: groupController.text,
                      );
                      Navigator.of(sheetContext).pop();
                    },
                    icon: const Icon(Icons.add_rounded, color: AppColors.white),
                    label: const BodyTitle(text: 'إنشاء وإضافة الكورس', color: AppColors.white, fontSize: 15),
                  ),
                ),
              ],
            );
          },
        ),
      );
    },
  );
}
