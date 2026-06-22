import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/core/routes/app_routes.dart';
import 'package:wlcd/presentation/screens/favorites/favorites_store.dart';
import 'package:wlcd/presentation/widgets/course/course_card.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class FavoriteCoursesScreen extends StatelessWidget {
  const FavoriteCoursesScreen({super.key, required this.groupName});

  final String groupName;

  FavoriteGroup? _findGroup(List<FavoriteGroup> groups) {
    for (final group in groups) {
      if (group.name == groupName) return group;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<FavoriteGroup>>(
      valueListenable: FavoritesStore.groups,
      builder: (context, groups, _) {
        final group = _findGroup(groups);

        return Scaffold(
          backgroundColor: AppColors.backGround,
          appBar: CustomAppBar(title: group?.name ?? groupName, centerTitle: true, showBackButton: true),
          body: group == null ? const _MissingFavoriteGroupView() : _FavoriteCoursesList(group: group),
        );
      },
    );
  }
}

class _FavoriteCoursesList extends StatelessWidget {
  const _FavoriteCoursesList({required this.group});

  final FavoriteGroup group;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsetsDirectional.only(
            start: AppPaddingWidth.p18,
            end: AppPaddingWidth.p18,
            bottom: AppPaddingHeight.p110,
            top: AppPaddingHeight.p10,
          ),
          sliver: SliverList.builder(
            itemCount: group.courses.length,
            itemBuilder: (context, index) {
              final course = group.courses[index];
              return Padding(
                padding: EdgeInsets.only(bottom: AppPaddingHeight.p10),
                child: CourseCard(
                  onTap: () => CourseDetailsRoute().push(context),
                  title: course.title,
                  price: course.price,
                  ratingCount: course.ratingCount,
                  thumbnailColor: course.thumbnailColor,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _MissingFavoriteGroupView extends StatelessWidget {
  const _MissingFavoriteGroupView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p20),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SectionTitle(text: 'هذه المجموعة غير متاحة حالياً', color: AppColors.text, textAlign: TextAlign.center),
            SizedBox(height: 8),
            BodyTitle(text: 'قد تكون المجموعة حُذفت أو تغيّر اسمها.', color: AppColors.muted, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
