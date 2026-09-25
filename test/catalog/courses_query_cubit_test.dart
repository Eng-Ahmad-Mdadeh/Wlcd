import 'package:flutter_test/flutter_test.dart';
import 'package:wlcd/domain/entity/catalog/get_courses_entity.dart';
import 'package:wlcd/presentation/cubit/catalog/courses_query_cubit.dart';

void main() {
  group('CoursesQueryCubit', () {
    test('updates search without dropping active filters', () {
      final cubit = CoursesQueryCubit(
        initial: const GetCoursesEntity(
          categoryId: 'category-id',
          difficulty: 'beginner',
          limit: 10,
        ),
      );

      cubit.setSearch('  Flutter  ');

      expect(cubit.state.q, 'Flutter');
      expect(cubit.state.categoryId, 'category-id');
      expect(cubit.state.difficulty, 'beginner');
      expect(cubit.state.limit, 10);
      cubit.close();
    });

    test('applies filters while preserving the search term and page limit', () {
      final cubit = CoursesQueryCubit(
        initial: const GetCoursesEntity(q: 'dart', limit: 10),
      );

      cubit.setFilters(
        const GetCoursesEntity(
          categoryId: 'category-id',
          tagIds: ['tag-id'],
          sort: '-publishedAt',
        ),
      );

      expect(cubit.state.q, 'dart');
      expect(cubit.state.limit, 10);
      expect(cubit.state.categoryId, 'category-id');
      expect(cubit.state.tagIds, ['tag-id']);
      expect(cubit.state.sort, '-publishedAt');
      cubit.close();
    });

    test('clears filters but retains search state', () {
      final cubit = CoursesQueryCubit(
        initial: const GetCoursesEntity(
          q: 'flutter',
          categoryId: 'category-id',
          isFree: true,
          limit: 10,
        ),
      );

      cubit.clearFilters();

      expect(cubit.state, const GetCoursesEntity(q: 'flutter', limit: 10));
      cubit.close();
    });
  });
}
