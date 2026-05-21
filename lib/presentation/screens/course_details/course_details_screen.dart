import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/image_view.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({super.key});

  static const List<Tab> _tabs = [
    Tab(text: 'About'),
    Tab(text: 'Lessons'),
    Tab(text: 'Reviews'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        backgroundColor: AppColors.white,
        bottomNavigationBar: SafeArea(
          top: false,
          child: Padding(
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.r28)),
                      ),
                      onPressed: () {},
                      child: const BodyTitle(text: 'Buy \$69.00', color: AppColors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: NestedScrollView(
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
                              child: const BodyTitle(
                                text: 'UX Design',
                                fontSize: 10,
                                color: AppColors.searchTagText,
                              ),
                            ),
                            const Spacer(),
                            const BodyTitle(text: '00', fontSize: 12, color: AppColors.searchRatingText),
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
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _TabBarHeaderDelegate(
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
                          dividerColor: Colors.transparent,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(AppRadius.r10),
                          ),
                          labelColor: AppColors.searchCardTitle,
                          unselectedLabelColor: AppColors.searchCardTitle,
                          labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                          unselectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                          padding: EdgeInsets.all(AppPaddingWidth.p4),
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                _AboutTab(),
                _LessonsTab(),
                _ReviewsTab(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TabBarHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _TabBarHeaderDelegate({required this.child});

  final Widget child;

  @override
  double get minExtent => 64;

  @override
  double get maxExtent => 64;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) => child;

  @override
  bool shouldRebuild(covariant _TabBarHeaderDelegate oldDelegate) => oldDelegate.child != child;
}

class _AboutTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const PageStorageKey('about-tab-scroll'),
      padding: EdgeInsets.fromLTRB(AppPaddingWidth.p18, 0, AppPaddingWidth.p18, AppPaddingHeight.p90),
      children: const [
        SectionTitle(text: 'Descriptions', fontSize: 18, color: AppColors.searchCardTitle),
        SizedBox(height: 8),
        BodyTitle(
          text:
              'Hi there! 👋 My name is Olivia Smith and welcome to this course. Digital products are more abstract and complex than any product you\'ve learned before. People are using their products in real-time and fast changing.',
          fontSize: 13,
          color: AppColors.searchRatingText,
          maxLines: 20,
        ),
      ],
    );
  }
}

class _LessonsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const lessons = [
      ('Instructor Introduction', '04:00', false),
      ('Design Shortgage', '03:49', false),
      ('Make it Pretty', '03:49', true),
      ('Copy Inspiration', '04:25', true),
      ('Summary', '02:06', true),
    ];

    return ListView(
      key: const PageStorageKey('lessons-tab-scroll'),
      padding: EdgeInsets.fromLTRB(AppPaddingWidth.p18, 0, AppPaddingWidth.p18, AppPaddingHeight.p90),
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.searchCardBorder),
            borderRadius: BorderRadius.circular(AppRadius.r14),
          ),
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: lessons.length + 1,
            separatorBuilder: (_, __) => const Divider(height: 1, color: AppColors.searchCardBorder),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: BodyTitle(text: 'Class', fontSize: 16, color: AppColors.searchCardTitle),
                );
              }

              final lesson = lessons[index - 1];
              return ListTile(
                dense: true,
                leading: const Icon(Icons.play_circle_fill, size: 18, color: AppColors.searchRatingText),
                title: BodyTitle(text: lesson.$1, fontSize: 14, color: AppColors.searchCardTitle),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BodyTitle(text: lesson.$2, fontSize: 13, color: AppColors.searchRatingText),
                    if (lesson.$3) ...[
                      SizedBox(width: AppWidth.w6),
                      const Icon(Icons.lock_outline, size: 14, color: AppColors.searchRatingText),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ReviewsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const PageStorageKey('reviews-tab-scroll'),
      padding: EdgeInsets.fromLTRB(AppPaddingWidth.p18, 0, AppPaddingWidth.p18, AppPaddingHeight.p90),
      children: [
        const SectionTitle(text: 'Ratings', fontSize: 18, color: AppColors.searchCardTitle),
        SizedBox(height: AppHeight.h12),
        Container(
          padding: EdgeInsets.all(AppPaddingWidth.p16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.searchCardBorder),
            borderRadius: BorderRadius.circular(AppRadius.r14),
          ),
          child: Column(
            children: [
              const BodyTitle(text: 'Customer Review', fontSize: 22, color: AppColors.searchCardTitle),
              SizedBox(height: AppHeight.h8),
              const BodyTitle(text: '⭐⭐⭐⭐⭐  4.5 out of 5', fontSize: 14, color: AppColors.searchRatingText),
            ],
          ),
        ),
        SizedBox(height: AppHeight.h18),
        const SectionTitle(text: 'User reviews', fontSize: 18, color: AppColors.searchCardTitle),
        SizedBox(height: AppHeight.h10),
        const BodyTitle(
          text:
              'Merrill Kervin\n3 weeks ago\n\nPulvinar nisl blandit cras lacus diam posuere. Varius sem vestibulum egestas ultricies.',
          fontSize: 13,
          color: AppColors.searchRatingText,
        ),
      ],
    );
  }
}
