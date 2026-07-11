import 'package:flutter/material.dart';
import 'package:wlcd/core/extension/localization_extension.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/core/routes/app_routes.dart';
import 'package:wlcd/presentation/screens/Home/widgets/banners.dart';
import 'package:wlcd/presentation/screens/Home/widgets/continue_learning_card.dart';
import 'package:wlcd/presentation/screens/Home/widgets/external_courses_section.dart';
import 'package:wlcd/presentation/screens/Home/widgets/home_header.dart';
import 'package:wlcd/presentation/screens/Home/widgets/home_trainers_section.dart';
import 'package:wlcd/presentation/screens/Home/widgets/section_header.dart';
import 'package:wlcd/presentation/screens/teachers/widgets/teacher_data.dart';
import 'package:wlcd/presentation/widgets/course/courses_grid.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recentCourses = [
      CourseData(
        category: context.loc.home_course_category_finance,
        title: context.loc.home_course_title_investment_banking,
        price: r'$120.00',
        duration: '12h 03m',
        posterType: CoursePosterType.dark,
      ),
      CourseData(
        category: context.loc.home_course_category_finance,
        title: context.loc.home_course_title_investment_banking_zero,
        price: r'$96.00',
        duration: '9h 40m',
        posterType: CoursePosterType.book,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        backgroundColor: AppColors.primary,
        title: 'WLCD Academy',
        colorTitle: AppColors.white,
        centerTitle: true,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            forceElevated: false,
            forceMaterialTransparency: true,
            backgroundColor: AppColors.primary,
            surfaceTintColor: AppColors.primary,
            floating: true,
            snap: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned(
                    top: 0,
                    child: HomeHeader(searchController: _searchController, onSearchChanged: (value) {}),
                  ),
                  Positioned(top: AppHeight.h150, child: const ContinueLearningCard()),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              AppPaddingWidth.p23,
              AppPaddingHeight.p20,
              AppPaddingWidth.p23,
              AppPaddingHeight.p100,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                BannersWidget(),

                SizedBox(height: AppHeight.h28),
                SectionHeaderRow(
                  title: context.loc.home_recently_added,
                  actionText: context.loc.home_see_more,
                  onActionPressed: _showRecentlyAddedMessage,
                ),
                SizedBox(height: AppHeight.h14),
                CoursesGrid(courses: recentCourses),
                SizedBox(height: AppHeight.h28),
                SectionHeaderRow(title: context.loc.home_global_courses),
                SizedBox(height: AppHeight.h14),
                const ExternalCoursesSection(),
                SizedBox(height: AppHeight.h28),

                SectionHeaderRow(
                  title: context.loc.home_explore_trainers,
                  actionText: context.loc.home_see_more,
                  onActionPressed: () => TeachersRoute().push(context),
                ),
                SizedBox(height: AppHeight.h14),
                const HomeTrainersSection(trainers: teachers),

                SizedBox(height: AppHeight.h28),
                SectionHeaderRow(
                  title: context.loc.home_recently_added,
                  actionText: context.loc.home_see_more,
                  onActionPressed: _showRecentlyAddedMessage,
                ),
                SizedBox(height: AppHeight.h14),
                CoursesGrid(courses: recentCourses),
                SizedBox(height: AppHeight.h24),

              ]),
            ),
          ),
        ],
      ),
    );
  }

  void _showRecentlyAddedMessage() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.loc.home_opening_recently_added)));
  }
}
