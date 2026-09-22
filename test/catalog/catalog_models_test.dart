import 'package:flutter_test/flutter_test.dart';
import 'package:wlcd/data/model/catalog/banners/banners_model.dart';
import 'package:wlcd/data/model/catalog/course_filters/course_filters_model.dart';
import 'package:wlcd/data/model/catalog/global_platforms/global_platforms_model.dart';

void main() {
  test('parses banners response', () {
    final result = BannersModel.fromJson({
      'data': [
        {
          'bannerId': 'banner-id',
          'image': 'https://example.com/banner.png',
          'categoryId': 'category-id',
          'courseId': null,
          'link': null,
        },
      ],
    });

    expect(result.banners.single.bannerId, 'banner-id');
    expect(result.banners.single.categoryId, 'category-id');
    expect(result.banners.single.courseId, isNull);
  });

  test('parses global platforms response', () {
    final result = GlobalPlatformsModel.fromJson({
      'data': [
        {
          'id': 'platform-id',
          'title': 'Coursera',
          'tag': 'منصة عالمية',
          'image': 'https://example.com/coursera.png',
          'description': 'Description',
          'link': 'https://www.coursera.org',
        },
      ],
    });

    expect(result.platforms.single.title, 'Coursera');
    expect(result.platforms.single.link, 'https://www.coursera.org');
  });

  test('also parses named and direct list collection responses', () {
    final banners = BannersModel.fromJson({'banners': <dynamic>[]});
    final platforms = GlobalPlatformsModel.fromJson({
      'globalPlatforms': <dynamic>[],
    });
    final directPlatforms = GlobalPlatformsModel.fromJson(<dynamic>[]);

    expect(banners.banners, isEmpty);
    expect(platforms.platforms, isEmpty);
    expect(directPlatforms.platforms, isEmpty);
  });

  test('normalizes category and tag identifiers in course filters', () {
    final result = CourseFiltersModel.fromJson({
      'categories': [
        {'categoryId': 'category-id', 'label': 'البرمجة'},
      ],
      'tags': [
        {'tagId': 'tag-id', 'label': 'فلاتر'},
      ],
      'languages': ['ar'],
      'currencies': ['SAR'],
      'priceCurrency': 'SAR',
      'priceMin': '0.00',
      'priceMax': '249.00',
      'hasFree': true,
      'hasPaid': true,
      'difficulties': ['beginner', 'intermediate', 'advanced'],
      'sortOptions': ['-publishedAt', 'publishedAt', 'title', '-title'],
    });

    expect(result.categories.single.id, 'category-id');
    expect(result.tags.single.id, 'tag-id');
    expect(result.priceMax, '249.00');
    expect(result.hasFree, isTrue);
  });
}
