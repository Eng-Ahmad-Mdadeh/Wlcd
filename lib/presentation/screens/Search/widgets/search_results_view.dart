import 'package:flutter/material.dart';
import 'package:local_hero_transform/local_hero_transform.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/Search/widgets/search_course_data.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class SearchResultsView extends StatelessWidget {
  const SearchResultsView({super.key, required this.courses, required this.tabController});
  final List<SearchCourseData> courses;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) return const Center(child: BodyTitle(text: 'No courses found'));

    return LocalHeroViews(
      tabController: tabController,
      itemCount: courses.length,
      onPressedCard: (_) {},
      itemsModel: (index) {
        final course = courses[index];
        return ItemsModel(
          image: DecorationImage(image: NetworkImage(course.imageUrl), fit: BoxFit.cover),
          name: BodyTitle(
            text: course.category,
            color: const Color(0xff16a34a),
            fontSize: 9,
            fontWeight: FontWeight.w700,
          ),
          title: SectionTitle(
            text: course.title,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            color: const Color(0xff111827),
            fontSize: 14,
          ),
          subTitle: BodyTitle(
            text: '${course.rating} (${course.reviews})',
            color: const Color(0xff6b7280),
            fontSize: 12,
          ),
          subTitleIcon: const Icon(Icons.star, color: Color(0xfff6b93b), size: 14),
          favoriteIconButton: BodyTitle(
            text: '\$${course.price.toStringAsFixed(2)}',
            color: const Color(0xff2563eb),
            fontWeight: FontWeight.w800,
            fontSize: 14,
          ),
        );
      },
    );
  }
}
