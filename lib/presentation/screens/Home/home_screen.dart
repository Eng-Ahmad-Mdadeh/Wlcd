import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/Home/widgets/continue_learning_card.dart';
import 'package:wlcd/presentation/screens/Home/widgets/courses_grid.dart';
import 'package:wlcd/presentation/screens/Home/widgets/home_header.dart';
import 'package:wlcd/presentation/screens/Home/widgets/section_header.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<CourseData> _recentCourses = const [
    CourseData(
      category: 'Finance',
      title: 'The Complete Investment Banking Course 2023',
      price: r'$120.00',
      duration: '12h 03m',
      posterType: CoursePosterType.dark,
    ),
    CourseData(
      category: 'Finance',
      title: 'Guide to Investment Banking From Zero',
      price: r'$96.00',
      duration: '9h 40m',
      posterType: CoursePosterType.book,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  Positioned(top: 0, child: HomeHeader(searchController: _searchController, onSearchChanged: (value) {})),
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
                const SectionHeaderRow(title: 'Continue Learning'),
                SizedBox(height: AppHeight.h28),
                SectionHeaderRow(
                  title: 'Recently added',
                  actionText: 'See more',
                  onActionPressed: _showRecentlyAddedMessage,
                ),
                SizedBox(height: AppHeight.h14),
                CoursesGrid(courses: _recentCourses),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  void _showRecentlyAddedMessage() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Opening all recently added courses...')));
  }
}

