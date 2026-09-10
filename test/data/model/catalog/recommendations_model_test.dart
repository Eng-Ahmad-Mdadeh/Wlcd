import 'package:flutter_test/flutter_test.dart';
import 'package:wlcd/data/model/catalog/recommendations/recommendations_model.dart';

void main() {
  test('parses recommended course cards and recommendation metadata', () {
    final model = RecommendationsModel.fromJson({
      'data': [
        {
          'courseId': 'course-featured',
          'reasonCode': 'featured',
          'card': {
            'courseId': 'course-featured',
            'title': 'Introduction to Domain-Driven Design',
            'estimatedDurationSeconds': 7200,
            'publishedAt': '2026-08-09T20:34:04.000Z',
            'thumbnail': {
              'mediaId': 'thumbnail-id',
              'url': 'http://localhost/media/public/thumbnail-id',
              'deliveryType': 'public',
              'mimeType': 'image/png',
              'expiresAt': null,
              'cachePolicy': 'public-immutable',
              'fileName': 'ddd-thumbnail.png',
              'sizeBytes': 1024,
              'width': 640,
              'height': 360,
            },
            'price': {
              'amount': '149.00',
              'currency': 'SAR',
              'displayLabel': '149.00 SAR',
            },
            'isFree': false,
            'ratingAverage': null,
            'ratingCount': 0,
            'instructorId': 'instructor-id',
            'commercialAvailability': 'purchasable',
          },
        },
        {
          'courseId': 'course-interest',
          'reasonCode': 'interest',
          'card': {
            'courseId': 'course-interest',
            'thumbnail': null,
            'price': {
              'amount': '0.00',
              'currency': 'SAR',
              'displayLabel': 'Free',
            },
            'isFree': true,
            'ratingCount': 0,
            'commercialAvailability': 'free',
          },
        },
      ],
    });

    expect(model.data, hasLength(2));
    expect(model.data.first.reasonCode, 'featured');
    expect(model.data.first.card.estimatedDurationSeconds, 7200);
    expect(model.data.first.card.publishedAt, DateTime.utc(2026, 8, 9, 20, 34, 4));
    expect(model.data.first.card.thumbnail?.width, 640);
    expect(model.data.last.reasonCode, 'interest');
    expect(model.data.last.card.thumbnail, isNull);
    expect(model.data.last.card.isFree, isTrue);
  });
}
