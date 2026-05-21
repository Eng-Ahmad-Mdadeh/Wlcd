import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/Home/widgets/continue_learning_card.dart';
import 'package:wlcd/presentation/screens/Home/widgets/home_header.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<_CourseData> _recentCourses = const [
    _CourseData(
      category: 'Finance',
      title: 'The Complete Investment Banking Course 2023',
      price: r'$120.00',
      duration: '12h 03m',
      posterType: _CoursePosterType.dark,
    ),
    _CourseData(
      category: 'Finance',
      title: 'Guide to Investment Banking From Zero',
      price: r'$96.00',
      duration: '9h 40m',
      posterType: _CoursePosterType.book,
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
                const _SectionHeader(title: 'Continue Learning'),
                SizedBox(height: AppHeight.h28),
                _SectionHeader(
                  title: 'Recently added',
                  actionText: 'See more',
                  onActionPressed: _showRecentlyAddedMessage,
                ),
                SizedBox(height: AppHeight.h14),
                _CoursesGrid(courses: _recentCourses),
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

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.actionText, this.onActionPressed});

  final String title;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SectionTitle(text: title, color: AppColors.text, fontSize: AppFontSize.s15, fontWeight: AppFontWeight.extraBold),
        if (actionText != null)
          TextButton(
            onPressed: onActionPressed,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              foregroundColor: AppColors.seeMore,
            ),
            child: BodyTitle(
              text: actionText!,
              color: AppColors.seeMore,
              fontSize: AppFontSize.s12,
              fontWeight: AppFontWeight.bold,
            ),
          ),
      ],
    );
  }
}

class _CoursesGrid extends StatelessWidget {
  const _CoursesGrid({required this.courses});

  final List<_CourseData> courses;

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: AppPaddingHeight.p30),
        child: Center(
          child: BodyTitle(
            text: 'No courses found',
            color: AppColors.muted,
            fontSize: AppFontSize.s14,
            fontWeight: AppFontWeight.semiBold,
          ),
        ),
      );
    }

    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: courses.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppWidth.w18,
        mainAxisSpacing: AppHeight.h18,
        childAspectRatio: .75,
      ),
      itemBuilder: (context, index) => _CourseCard(course: courses[index]),
    );
  }
}

class _CourseCard extends StatelessWidget {
  const _CourseCard({required this.course});

  final _CourseData course;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [BoxShadow(color: AppColors.greySec, spreadRadius: -1, blurRadius: 4, offset: Offset(0, 3))],
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.r12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CoursePoster(type: course.posterType),
          SizedBox(height: AppHeight.h12),
          Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: AppPaddingWidth.p10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BodyTitle(
                  text: course.category,
                  color: AppColors.danger,
                  fontSize: AppFontSize.s10,
                  fontWeight: AppFontWeight.extraBold,
                ),
                SizedBox(height: AppHeight.h6),
                SectionTitle(
                  text: course.title,
                  color: AppColors.text,
                  fontSize: AppFontSize.s13,
                  height: 1.35,
                  fontWeight: AppFontWeight.extraBold,
                  maxLines: 2,
                ),
                SizedBox(height: AppHeight.h10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BodyTitle(
                      text: course.price,
                      color: AppColors.accent,
                      fontSize: AppFontSize.s13,
                      fontWeight: AppFontWeight.extraBold,
                    ),
                    BodyTitle(
                      text: course.duration,
                      color: AppColors.muted,
                      fontSize: AppFontSize.s10,
                      fontWeight: AppFontWeight.bold,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CoursePoster extends StatelessWidget {
  const _CoursePoster({required this.type});

  final _CoursePosterType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppHeight.h130,
      decoration: BoxDecoration(
        color: AppColors.text,
        borderRadius: BorderRadius.circular(AppRadius.r7),
        boxShadow: [
          BoxShadow(color: AppColors.text.withOpacity(.11), blurRadius: AppRadius.r18, offset: Offset(0, AppHeight.h7)),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: type == _CoursePosterType.dark ? const _DarkPosterArt() : const _BookPosterArt(),
    );
  }
}

class _DarkPosterArt extends StatelessWidget {
  const _DarkPosterArt();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF030712), Color(0xFF111827), Color(0xFF0F172A)],
                stops: [0, .52, 1],
              ),
            ),
          ),
        ),
        PositionedDirectional(top: AppHeight.h35, start: AppWidth.w25, child: const _CodeBadge()),
        PositionedDirectional(top: AppHeight.h32, end: AppWidth.w40, child: const _PosterDot(color: Color(0xFF3B82F6))),
        PositionedDirectional(top: AppHeight.h55, start: AppWidth.w60, child: const _PosterDot(color: Color(0xFFEF4444))),
      ],
    );
  }
}

class _CodeBadge extends StatelessWidget {
  const _CodeBadge();

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -.31,
      child: Container(
        width: AppWidth.w90,
        height: AppHeight.h54,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.r10),
          border: Border.all(color: const Color(0xFF2563EB), width: AppWidth.w1 * 2),
          boxShadow: const [BoxShadow(color: Color(0x662563EB), blurRadius: 18)],
        ),
        child: SectionTitle(text: '</>', color: AppColors.white, fontSize: AppFontSize.s18, fontWeight: AppFontWeight.extraBold),
      ),
    );
  }
}

class _PosterDot extends StatelessWidget {
  const _PosterDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(width: AppWidth.w5, height: AppHeight.h5, decoration: BoxDecoration(color: color, shape: BoxShape.circle));
  }
}

class _BookPosterArt extends StatelessWidget {
  const _BookPosterArt();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: const [
            Expanded(flex: 35, child: ColoredBox(color: Color(0xFFFFDE59))),
            Expanded(flex: 35, child: ColoredBox(color: Color(0xFFFF5757))),
            Expanded(flex: 30, child: ColoredBox(color: Color(0xFF2DD4BF))),
          ],
        ),
        PositionedDirectional(top: AppHeight.h18, start: AppWidth.w18, child: const _BookPosterLabel(text: 'GUIDE', fontSize: 19)),
        PositionedDirectional(start: AppWidth.w18, bottom: AppHeight.h18, child: const _BookPosterLabel(text: 'HTML CSS JS', fontSize: 14)),
      ],
    );
  }
}

class _BookPosterLabel extends StatelessWidget {
  const _BookPosterLabel({required this.text, required this.fontSize});

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p8, vertical: AppPaddingHeight.p5),
      decoration: BoxDecoration(color: AppColors.white.withOpacity(.88), borderRadius: BorderRadius.circular(AppRadius.r4)),
      child: SectionTitle(text: text, color: AppColors.text, fontSize: fontSize, fontWeight: AppFontWeight.extraBold, height: 1.3),
    );
  }
}

class _CourseData {
  const _CourseData({required this.category, required this.title, required this.price, required this.duration, required this.posterType});

  final String category;
  final String title;
  final String price;
  final String duration;
  final _CoursePosterType posterType;
}

enum _CoursePosterType { dark, book }
