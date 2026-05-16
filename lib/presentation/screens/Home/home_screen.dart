import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/section_card.dart';
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
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor: _HomeColors.primary,
            surfaceTintColor: _HomeColors.primary,
            elevation: 0,
            toolbarHeight: AppHeight.h170,
            flexibleSpace: SafeArea(
              bottom: false,
              child: _HomeHeader(
                searchController: _searchController,
                onSearchChanged: (value) {},
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
              delegate: SliverChildListDelegate(
                [
                  const _SectionHeader(title: 'Continue Learning'),
                  SizedBox(height: AppHeight.h14),
                  const _ContinueLearningCard(),
                  SizedBox(height: AppHeight.h28),
                  _SectionHeader(
                    title: 'Recently added',
                    actionText: 'See more',
                    onActionPressed: _showRecentlyAddedMessage,
                  ),
                  SizedBox(height: AppHeight.h14),
                  _CoursesGrid(courses: _recentCourses),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showRecentlyAddedMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening all recently added courses...')),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({
    required this.searchController,
    required this.onSearchChanged,
  });

  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppPaddingWidth.p23,
        0,
        AppPaddingWidth.p23,
        AppPaddingHeight.p23,
      ),
      child: Column(
        children: [
          SizedBox(height: AppHeight.h15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(child: _WelcomeText()),
              SizedBox(width: AppWidth.w12),
              const _HeaderActions(),
            ],
          ),
          SizedBox(height: AppHeight.h24),
          _HomeSearchField(
            controller: searchController,
            onChanged: onSearchChanged,
          ),
        ],
      ),
    );
  }
}

class _WelcomeText extends StatelessWidget {
  const _WelcomeText();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Welcome, Jason ',
            style: TextStyle(
              color: AppColors.white,
              fontSize: AppFontSize.s16,
              fontWeight: AppFontWeight.extraBold,
              fontFamily: AppFontFamily.rubik,
            ),
            children: const [TextSpan(text: '👋')],
          ),
        ),
        SizedBox(height: AppHeight.h7),
        BodyTitle(
          text: 'Upgrade your skill for better futures.',
          color: AppColors.white.withOpacity(.72),
          fontSize: AppFontSize.s12,
          fontWeight: AppFontWeight.medium,
        ),
      ],
    );
  }
}

class _HeaderActions extends StatelessWidget {
  const _HeaderActions();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _HeaderIconButton(icon: Icons.search, semanticLabel: 'Search'),
        SizedBox(width: AppWidth.w8),
        const _HeaderIconButton(
          icon: Icons.notifications_none_outlined,
          semanticLabel: 'Notifications',
          showDot: true,
        ),
      ],
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({
    required this.icon,
    required this.semanticLabel,
    this.showDot = false,
  });

  final IconData icon;
  final String semanticLabel;
  final bool showDot;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      child: Container(
        width: AppWidth.w30,
        height: AppHeight.h30,
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(.08),
          borderRadius: BorderRadius.circular(AppRadius.r15),
          border: Border.all(color: AppColors.white.withOpacity(.28)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(icon, color: AppColors.white, size: AppSize.s17),
            if (showDot)
              PositionedDirectional(
                top: AppHeight.h7,
                end: AppWidth.w7,
                child: Container(
                  width: AppWidth.w6,
                  height: AppHeight.h6,
                  decoration: BoxDecoration(
                    color: _HomeColors.notificationDot,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _HomeColors.primary,
                      width: AppWidth.w1,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _HomeSearchField extends StatelessWidget {
  const _HomeSearchField({required this.controller, required this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppHeight.h52,
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(.06),
        borderRadius: BorderRadius.circular(AppRadius.r7),
        border: Border.all(color: AppColors.white.withOpacity(.14)),
      ),
      padding: EdgeInsetsDirectional.symmetric(horizontal: AppPaddingWidth.p15),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: AppColors.white.withOpacity(.72),
            size: AppSize.s18,
          ),
          SizedBox(width: AppWidth.w11),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              cursorColor: AppColors.white,
              style: TextStyle(
                color: AppColors.white,
                fontSize: AppFontSize.s13,
                fontFamily: AppFontFamily.rubik,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: 'What do you want to learn?',
                hintStyle: TextStyle(
                  color: AppColors.white.withOpacity(.58),
                  fontSize: AppFontSize.s13,
                  fontFamily: AppFontFamily.rubik,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    this.actionText,
    this.onActionPressed,
  });

  final String title;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SectionTitle(
          text: title,
          color: _HomeColors.text,
          fontSize: AppFontSize.s15,
          fontWeight: AppFontWeight.extraBold,
        ),
        if (actionText != null)
          TextButton(
            onPressed: onActionPressed,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              foregroundColor: _HomeColors.seeMore,
            ),
            child: BodyTitle(
              text: actionText!,
              color: _HomeColors.seeMore,
              fontSize: AppFontSize.s12,
              fontWeight: AppFontWeight.bold,
            ),
          ),
      ],
    );
  }
}

class _ContinueLearningCard extends StatelessWidget {
  const _ContinueLearningCard();

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(AppRadius.r7),
      backgroundColor: AppColors.white,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.r7),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(AppPaddingWidth.p13),
              child: Row(
                children: [
                  const _ContinueCourseThumb(),
                  SizedBox(width: AppWidth.w14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BodyTitle(
                          text: 'Website',
                          color: _HomeColors.warning,
                          fontSize: AppFontSize.s10,
                          fontWeight: AppFontWeight.extraBold,
                        ),
                        SizedBox(height: AppHeight.h5),
                        SectionTitle(
                          text: 'Fundamentals of HTML & CSS From Scratch',
                          color: _HomeColors.text,
                          fontSize: AppFontSize.s13,
                          fontWeight: AppFontWeight.extraBold,
                          height: 1.32,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppPaddingWidth.p13,
                0,
                AppPaddingWidth.p13,
                AppPaddingHeight.p10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ProgressText(text: '24 of 33 Lessons'),
                  _ProgressText(text: '75% completed'),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(AppRadius.r7),
              ),
              child: LinearProgressIndicator(
                minHeight: AppHeight.h4,
                value: .75,
                backgroundColor: _HomeColors.progressTrack,
                valueColor: const AlwaysStoppedAnimation<Color>(_HomeColors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContinueCourseThumb extends StatelessWidget {
  const _ContinueCourseThumb();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppWidth.w80,
      height: AppHeight.h60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.r4),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF9FB6C9),
            Color(0xFFEEF3F7),
            Color(0xFF885A47),
            Color(0xFF3F2F2D),
          ],
          stops: [0, .42, .43, 1],
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(color: const Color(0x33141C41)),
          ),
          PositionedDirectional(
            top: AppHeight.h7,
            start: AppWidth.w7,
            end: AppWidth.w7,
            bottom: AppHeight.h7,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.r2),
                border: Border.all(
                  color: AppColors.white.withOpacity(.65),
                  width: AppWidth.w1,
                ),
              ),
            ),
          ),
          PositionedDirectional(
            start: AppWidth.w16,
            bottom: AppHeight.h11,
            child: Container(
              width: AppWidth.w40,
              height: AppHeight.h5,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(.8),
                borderRadius: BorderRadius.circular(AppRadius.r4),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.white.withOpacity(.45),
                    offset: Offset(0, -AppHeight.h10),
                    spreadRadius: AppHeight.h1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressText extends StatelessWidget {
  const _ProgressText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return BodyTitle(
      text: text,
      color: _HomeColors.muted,
      fontSize: AppFontSize.s10,
      fontWeight: AppFontWeight.bold,
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
            color: _HomeColors.muted,
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
        childAspectRatio: .58,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CoursePoster(type: course.posterType),
        SizedBox(height: AppHeight.h12),
        BodyTitle(
          text: course.category,
          color: _HomeColors.danger,
          fontSize: AppFontSize.s10,
          fontWeight: AppFontWeight.extraBold,
        ),
        SizedBox(height: AppHeight.h6),
        SectionTitle(
          text: course.title,
          color: _HomeColors.text,
          fontSize: AppFontSize.s13,
          height: 1.35,
          fontWeight: AppFontWeight.extraBold,
          maxLines: 2,
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BodyTitle(
              text: course.price,
              color: _HomeColors.accent,
              fontSize: AppFontSize.s13,
              fontWeight: AppFontWeight.extraBold,
            ),
            BodyTitle(
              text: course.duration,
              color: _HomeColors.muted,
              fontSize: AppFontSize.s10,
              fontWeight: AppFontWeight.bold,
            ),
          ],
        ),
      ],
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
        color: _HomeColors.text,
        borderRadius: BorderRadius.circular(AppRadius.r7),
        boxShadow: [
          BoxShadow(
            color: _HomeColors.text.withOpacity(.11),
            blurRadius: AppRadius.r18,
            offset: Offset(0, AppHeight.h7),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: type == _CoursePosterType.dark
          ? const _DarkPosterArt()
          : const _BookPosterArt(),
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
                colors: [
                  Color(0xFF030712),
                  Color(0xFF111827),
                  Color(0xFF0F172A),
                ],
                stops: [0, .52, 1],
              ),
            ),
          ),
        ),
        PositionedDirectional(
          top: AppHeight.h35,
          start: AppWidth.w25,
          child: const _CodeBadge(),
        ),
        PositionedDirectional(
          top: AppHeight.h32,
          end: AppWidth.w40,
          child: const _PosterDot(color: Color(0xFF3B82F6)),
        ),
        PositionedDirectional(
          top: AppHeight.h55,
          start: AppWidth.w60,
          child: const _PosterDot(color: Color(0xFFEF4444)),
        ),
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
          border: Border.all(
            color: const Color(0xFF2563EB),
            width: AppWidth.w1 * 2,
          ),
          boxShadow: const [BoxShadow(color: Color(0x662563EB), blurRadius: 18)],
        ),
        child: SectionTitle(
          text: '</>',
          color: AppColors.white,
          fontSize: AppFontSize.s18,
          fontWeight: AppFontWeight.extraBold,
        ),
      ),
    );
  }
}

class _PosterDot extends StatelessWidget {
  const _PosterDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppWidth.w5,
      height: AppHeight.h5,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
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
        PositionedDirectional(
          top: AppHeight.h18,
          start: AppWidth.w18,
          child: const _BookPosterLabel(text: 'GUIDE', fontSize: 19),
        ),
        PositionedDirectional(
          start: AppWidth.w18,
          bottom: AppHeight.h18,
          child: const _BookPosterLabel(text: 'HTML CSS JS', fontSize: 14),
        ),
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
      padding: EdgeInsets.symmetric(
        horizontal: AppPaddingWidth.p8,
        vertical: AppPaddingHeight.p5,
      ),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(.88),
        borderRadius: BorderRadius.circular(AppRadius.r4),
      ),
      child: SectionTitle(
        text: text,
        color: _HomeColors.text,
        fontSize: fontSize,
        fontWeight: AppFontWeight.extraBold,
        height: 1.3,
      ),
    );
  }
}

class _CourseData {
  const _CourseData({
    required this.category,
    required this.title,
    required this.price,
    required this.duration,
    required this.posterType,
  });

  final String category;
  final String title;
  final String price;
  final String duration;
  final _CoursePosterType posterType;
}

enum _CoursePosterType { dark, book }

class _HomeColors {
  const _HomeColors._();

  static const Color primary = Color(0xFF1F275D);
  static const Color accent = Color(0xFF1665E7);
  static const Color danger = Color(0xFFF04444);
  static const Color notificationDot = Color(0xFFFF4D6D);
  static const Color text = Color(0xFF111827);
  static const Color muted = Color(0xFF7B8191);
  static const Color seeMore = Color(0xFF495063);
  static const Color warning = Color(0xFFF59E0B);
  static const Color progressTrack = Color(0xFFE8EAF5);
  static const Color navInactive = Color(0xFFA0A7B5);
}
