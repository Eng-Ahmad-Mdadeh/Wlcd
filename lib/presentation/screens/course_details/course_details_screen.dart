import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/course_details/widgets/announcements_tab.dart';
import 'package:wlcd/presentation/screens/course_details/widgets/downloaded_tab.dart';
import 'package:wlcd/presentation/screens/course_details/widgets/lessons_tab.dart';
import 'package:wlcd/presentation/screens/course_details/widgets/resources_tab.dart';
import 'package:wlcd/presentation/screens/course_details/widgets/tab_bar_header_delegate.dart';
import 'package:wlcd/presentation/widgets/image_view.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class CourseDetailsScreen extends StatefulWidget {
  const CourseDetailsScreen({super.key});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  static const int _initialSectionIndex = 2;
  static const List<_CourseDetailsSection> _sections = [
    _CourseDetailsSection(title: 'Lessons', page: LessonsTab()),
    _CourseDetailsSection(title: 'Announcements', page: AnnouncementsTab()),
    _CourseDetailsSection(title: 'Downloaded', page: DownloadedTab()),
    _CourseDetailsSection(title: 'Resources', page: ResourcesTab()),
  ];

  late final PageController _pageController;
  late final ScrollController _sectionsScrollController;
  late final List<GlobalKey> _sectionKeys;
  final ValueNotifier<int> _selectedSectionIndexNotifier = ValueNotifier<int>(_initialSectionIndex);

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _initialSectionIndex);
    _sectionsScrollController = ScrollController();
    _sectionKeys = List.generate(_sections.length, (_) => GlobalKey());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _ensureSelectedSectionIsVisible(animated: false);
    });
  }

  @override
  void dispose() {
    _selectedSectionIndexNotifier.dispose();
    _sectionsScrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _selectSection(int index) {
    if (_selectedSectionIndexNotifier.value == index) return;

    _setSelectedSection(index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  void _handlePageChanged(int index) {
    if (_selectedSectionIndexNotifier.value == index) return;

    _setSelectedSection(index);
  }

  void _setSelectedSection(int index) {
    _selectedSectionIndexNotifier.value = index;
    _ensureSelectedSectionIsVisible();
  }

  void _ensureSelectedSectionIsVisible({bool animated = true}) {
    final sectionContext = _sectionKeys[_selectedSectionIndexNotifier.value].currentContext;
    if (sectionContext == null) return;

    Scrollable.ensureVisible(
      sectionContext,
      duration: animated ? const Duration(milliseconds: 250) : Duration.zero,
      curve: Curves.easeInOut,
      alignment: .5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
        body: NestedScrollView(
          physics: const NeverScrollableScrollPhysics(),
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
                            imagePath: 'https://cdn.pixabay.com/photo/2019/08/09/06/12/car-racing-4394450_1280.jpg',
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
                            child: const BodyTitle(text: 'UX Design', fontSize: 10, color: AppColors.searchTagText),
                          ),
                          const Spacer(),
                          const BodyTitle(text: '00', fontSize: 12, color: AppColors.searchRatingText),
                          SizedBox(width: AppWidth.w8),
                          const BodyTitle(text: 'All Levels', fontSize: 12, color: AppColors.searchCardTitle),
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
                          const BodyTitle(text: '4.5 (7,765)', fontSize: 12, color: AppColors.searchRatingText),
                          SizedBox(
                            height: AppHeight.h15,
                            child: const VerticalDivider(color: AppColors.grey),
                          ),
                          const BodyTitle(text: '1,768 enrolled', fontSize: 12, color: AppColors.searchRatingText),
                          SizedBox(
                            height: AppHeight.h15,
                            child: const VerticalDivider(color: AppColors.grey),
                          ),
                          const BodyTitle(text: '30+ Lessons', fontSize: 12, color: AppColors.searchRatingText),
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
                delegate: TabBarHeaderDelegate(
                  child: Container(
                    color: AppColors.white,
                    padding: EdgeInsets.fromLTRB(AppPaddingWidth.p18, 0, AppPaddingWidth.p18, AppPaddingHeight.p12),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(AppRadius.r12),
                      ),
                      child: ValueListenableBuilder<int>(
                        valueListenable: _selectedSectionIndexNotifier,
                        builder: (context, selectedSectionIndex, _) {
                          return ListView.separated(
                            controller: _sectionsScrollController,
                            padding: EdgeInsets.all(AppPaddingWidth.p4),
                            scrollDirection: Axis.horizontal,
                            itemCount: _sections.length,
                            separatorBuilder: (_, __) => SizedBox(width: AppWidth.w6),
                            itemBuilder: (context, index) {
                              final isSelected = selectedSectionIndex == index;

                              return _CourseSectionTab(
                                key: _sectionKeys[index],
                                title: _sections[index].title,
                                isSelected: isSelected,
                                onTap: () => _selectSection(index),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: PageView(
            controller: _pageController,
            onPageChanged: _handlePageChanged,
            children: _sections.map((section) => section.page).toList(growable: false),
          ),
        ),
      ),
    );
  }
}

class _CourseDetailsSection {
  const _CourseDetailsSection({required this.title, required this.page});

  final String title;
  final Widget page;
}

class _CourseSectionTab extends StatelessWidget {
  const _CourseSectionTab({super.key, required this.title, required this.isSelected, required this.onTap});

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(AppRadius.r10);

    return Semantics(
      button: true,
      selected: isSelected,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.white,
          border: Border.all(color: AppColors.searchCardBorder),
          borderRadius: borderRadius,
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: borderRadius,
          child: InkWell(
            borderRadius: borderRadius,
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p12, vertical: AppPaddingHeight.p8),
              child: Center(
                child: BodyTitle(
                  text: title,
                  fontSize: 12,
                  color: isSelected ? AppColors.white : AppColors.searchRatingText,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
