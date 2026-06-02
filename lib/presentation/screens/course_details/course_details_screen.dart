import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/course_details/widgets/announcements_tab.dart';
import 'package:wlcd/presentation/screens/course_details/widgets/downloaded_tab.dart';
import 'package:wlcd/presentation/screens/course_details/widgets/lessons_tab.dart';
import 'package:wlcd/presentation/screens/course_details/widgets/resources_tab.dart';
import 'package:wlcd/presentation/widgets/image_view.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

import 'widgets/about_tab.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({super.key});

  static const _tabs = [
    Tab(text: 'Lessons'),
    Tab(text: 'About'),
    Tab(text: 'Announcements'),
    Tab(text: 'Downloaded'),
    Tab(text: 'Resources'),
  ];

  static const _pages = [
    LessonsTab(),
    AboutTab(),
    AnnouncementsTab(),
    DownloadedTab(),
    ResourcesTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      initialIndex: 2,
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
                  child: const Icon(Icons.favorite_border, color: AppColors.primary),
                ),
                SizedBox(width: AppWidth.w12),
                Expanded(
                  child: SizedBox(
                    height: AppHeight.h52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.r28),
                        ),
                      ),
                      onPressed: () {},
                      child: const BodyTitle(
                        text: 'Buy \$69.00',
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
                              imagePath:
                                  'https://cdn.pixabay.com/photo/2019/08/09/06/12/car-racing-4394450_1280.jpg',
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
                              child: const Icon(
                                Icons.play_arrow_rounded,
                                color: AppColors.white,
                                size: 30,
                              ),
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
                              child: const BodyTitle(
                                text: 'UX Design',
                                fontSize: 10,
                                color: AppColors.searchTagText,
                              ),
                            ),
                            const Spacer(),
                            const BodyTitle(
                              text: '00',
                              fontSize: 12,
                              color: AppColors.searchRatingText,
                            ),
                            SizedBox(width: AppWidth.w8),
                            const BodyTitle(
                              text: 'All Levels',
                              fontSize: 12,
                              color: AppColors.searchCardTitle,
                            ),
                          ],
                        ),
                        SizedBox(height: AppHeight.h10),
                        const SectionTitle(
                          text: 'Master Digital Product Design:\nUX Research & UI Design',
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
                            const BodyTitle(
                              text: '4.5 (7,765)',
                              fontSize: 12,
                              color: AppColors.searchRatingText,
                            ),
                            SizedBox(
                              height: AppHeight.h15,
                              child: const VerticalDivider(color: AppColors.grey),
                            ),
                            const BodyTitle(
                              text: '1,768 enrolled',
                              fontSize: 12,
                              color: AppColors.searchRatingText,
                            ),
                            SizedBox(
                              height: AppHeight.h15,
                              child: const VerticalDivider(color: AppColors.grey),
                            ),
                            const BodyTitle(
                              text: '30+ Lessons',
                              fontSize: 12,
                              color: AppColors.searchRatingText,
                            ),
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
                  backgroundColor: AppColors.white,
                  surfaceTintColor: Colors.transparent,
                  elevation: 0,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(65),
                    child: Container(
                      color: AppColors.white,
                      padding: EdgeInsets.fromLTRB(
                        AppPaddingWidth.p18,
                        0,
                        AppPaddingWidth.p18,
                        AppPaddingHeight.p12,
                      ),
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
                            borderRadius: BorderRadius.circular(AppRadius.r10),
                          ),
                          labelColor: AppColors.white,
                          unselectedLabelColor: AppColors.searchRatingText,
                          labelStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          unselectedLabelStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          padding: EdgeInsets.all(AppPaddingWidth.p4),
                          labelPadding: EdgeInsets.symmetric(
                            horizontal: AppPaddingWidth.p12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: const TabBarView(children: _pages),
          ),
        ),
      ),
    );
  }
}
