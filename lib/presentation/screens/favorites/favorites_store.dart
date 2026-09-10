import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';

class FavoriteCourse {
  const FavoriteCourse({required this.title, required this.price, required this.ratingCount, required this.thumbnailColor});

  final String title;
  final String price;
  final String ratingCount;
  final Color thumbnailColor;
}

class FavoriteGroup {
  const FavoriteGroup({required this.favoriteGroupId, required this.name, required this.courses});

  final String favoriteGroupId;
  final String name;
  final List<FavoriteCourse> courses;
}

class FavoritesStore {
  FavoritesStore._();

  static const demoCourse = FavoriteCourse(
    title: 'User Experience Design\nEssentials: Figma UI UX\nDesign',
    price: '\$89.00',
    ratingCount: '(31,882)',
    thumbnailColor: AppColors.searchThumbBlue,
  );

  static final ValueNotifier<List<FavoriteGroup>> groups = ValueNotifier<List<FavoriteGroup>>([
    FavoriteGroup(favoriteGroupId: 'design', name: 'تصميم واجهات', courses: List.generate(4, (_) => demoCourse)),
    FavoriteGroup(favoriteGroupId: 'learn-later', name: 'أريد تعلمها لاحقاً', courses: List.generate(3, (_) => demoCourse)),
    FavoriteGroup(favoriteGroupId: 'work', name: 'كورسات العمل', courses: List.generate(2, (_) => demoCourse)),
  ]);

  static FavoriteGroup? findGroupByName(String name) {
    for (final group in groups.value) {
      if (group.name == name) return group;
    }
    return null;
  }

  static void addCourseToGroup({required FavoriteCourse course, required String groupName}) {
    final cleanName = groupName.trim();
    if (cleanName.isEmpty) return;

    final updatedGroups = [...groups.value];
    final groupIndex = updatedGroups.indexWhere((group) => group.name == cleanName);
    if (groupIndex == -1) {
      updatedGroups.insert(0, FavoriteGroup(favoriteGroupId: cleanName, name: cleanName, courses: [course]));
    } else {
      final group = updatedGroups[groupIndex];
      updatedGroups[groupIndex] = FavoriteGroup(favoriteGroupId: group.favoriteGroupId, name: group.name, courses: [course, ...group.courses]);
    }
    groups.value = updatedGroups;
  }
}
