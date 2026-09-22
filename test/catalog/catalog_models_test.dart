import 'package:flutter_test/flutter_test.dart';
import 'package:wlcd/data/model/catalog/banners/banners_model.dart';
import 'package:wlcd/data/model/catalog/course_filters/course_filters_model.dart';
import 'package:wlcd/data/model/catalog/global_platforms/global_platforms_model.dart';
import 'package:wlcd/data/model/catalog/courses/courses_model.dart';
import 'package:wlcd/domain/entity/catalog/get_courses_entity.dart';

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

  test('parses courses response and serializes all course filters', () {
    final result = CoursesModel.fromJson({
      'data': [
        {
          'courseId': 'course-id',
          'title': 'مقدمة في التصميم المعتمد على المجال',
          'subtitle': 'أسس بناء الأنظمة المعيارية',
          'thumbnailMediaId': 'media-id',
          'primaryCategoryLabel': 'هندسة البرمجيات',
          'difficulty': 'intermediate',
          'estimatedDurationSeconds': 7200,
          'instructorDisplayName': 'أحمد الخطيب',
          'publishedAt': '2026-09-21T01:55:22.000Z',
          'thumbnail': {
            'mediaId': 'media-id',
            'url': 'https://example.com/thumbnail.png',
            'deliveryType': 'public',
            'mimeType': 'image/png',
            'expiresAt': null,
            'cachePolicy': 'public-immutable',
            'fileName': 'thumbnail.png',
            'sizeBytes': 1024,
            'width': 640,
            'height': 360,
          },
          'price': {
            'amount': '149.00',
            'currency': 'SAR',
            'displayLabel': '149.00 ر.س',
          },
          'isFree': false,
          'ratingAverage': null,
          'ratingCount': 0,
          'instructorId': 'instructor-id',
          'commercialAvailability': 'purchasable',
        },
      ],
      'pagination': {'nextCursor': 'next-cursor', 'hasMore': true},
    });
    const entity = GetCoursesEntity(
      q: 'design',
      categoryId: 'category-id',
      tagIds: ['tag-1', 'tag-2'],
      difficulty: 'intermediate',
      language: 'ar',
      isFree: false,
      priceMin: 1,
      priceMax: 200,
      currency: 'SAR',
      sort: '-relevance',
      cursor: 'cursor',
    );

    expect(result.data.single.estimatedDurationSeconds, 7200);
    expect(result.data.single.thumbnail?.width, 640);
    expect(result.data.single.price?.amount, '149.00');
    expect(result.pagination?.nextCursor, 'next-cursor');
    expect(entity.toQueryParameters(), {
      'q': 'design',
      'categoryId': 'category-id',
      'tagIds': 'tag-1,tag-2',
      'difficulty': 'intermediate',
      'language': 'ar',
      'isFree': false,
      'priceMin': 1,
      'priceMax': 200,
      'currency': 'SAR',
      'sort': '-relevance',
      'cursor': 'cursor',
      'limit': 20,
    });
  });
}
