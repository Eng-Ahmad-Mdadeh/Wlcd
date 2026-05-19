import 'package:flutter/material.dart';
import 'package:local_hero_transform/local_hero_transform.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/presentation/screens/Search/widgets/search_course_data.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';

class SearchResultsView extends StatelessWidget {
  const SearchResultsView({super.key, required this.courses, required this.tabController});

  final List<SearchCourseData> courses;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) {
      return const Center(child: BodyTitle(text: 'No courses found'));
    }

    return LocalHeroViews(
      tabController: tabController,
      itemCount: courses.length,
      onPressedCard: (_) {},
      itemsModel: (index) {
        final course = courses[index];
        return ItemsModel(
          image: DecorationImage(image: NetworkImage(course.imageUrl), fit: BoxFit.cover),
          name: Text(course.category),
          title: Text(course.title),
          subTitle: Text('${course.rating}  (${course.reviews})'),
          subTitleIcon: const Icon(Icons.star, color: Colors.amber),
          favoriteIconButton: Text(
            '\$${course.price.toStringAsFixed(0)}',
            style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
