import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wlcd/data/model/course_details/course_details/course_details_model.dart';
import 'package:wlcd/presentation/screens/course_details/widgets/about_tab.dart';
import 'package:wlcd/presentation/screens/course_details/widgets/lessons_tab.dart';
import 'package:wlcd/presentation/screens/course_details/widgets/reviews_tab.dart';
import 'package:wlcd/presentation/screens/course_details/widgets/forum_tab.dart';
import 'package:wlcd/presentation/screens/course_details/widgets/resources_tab.dart';
import 'package:wlcd/presentation/screens/course_details/widgets/downloaded_tab.dart';

CourseDetailsModel fixture() => CourseDetailsModel.fromJson(
  jsonDecode(
        File(
          'test/course_details/fixtures/course_details.json',
        ).readAsStringSync(),
      )
      as Map<String, dynamic>,
);

void main() {
  test('parses the complete embedded tabs and capabilities response', () {
    final course = fixture();
    final tabs = course.tabs!;
    expect(course.availableTabs, [
      'overview',
      'curriculum',
      'reviews',
      'forum',
      'resources',
      'downloads',
    ]);
    expect(course.enrollmentState, 'enrolled');
    expect(course.commercialState, 'free');
    expect(course.forumCapability!.requiresEnrollment, isTrue);
    expect(course.resourcesCapability!.resourceCount, 2);
    expect(course.reviewsCapability!.reviewCount, 2);
    expect(
      course.bookingCapability!.instructorId,
      '01HXYZABCDEFGHJKMNPQRSTVZ9',
    );
    expect(tabs.overview!.instructor!.displayName, 'أحمد الخطيب');
    expect(tabs.overview!.price!.displayLabel, 'مجاني');
    expect(tabs.overview!.thumbnail, isNull);
    expect(tabs.curriculum!.data, course.curriculum);
    expect(
      tabs.curriculum!.data.first.lessons.first.durationEstimateSeconds,
      1200,
    );
    expect(tabs.curriculum!.data.last.lessons.first.isPreviewEligible, isTrue);
    expect(tabs.reviews!.ratingAverage, 4.5);
    expect(tabs.reviews!.data.first.rating, 5.0);
    expect(
      tabs.reviews!.data.first.publishedAt,
      DateTime.utc(2026, 10, 13, 23, 46, 33),
    );
    expect(tabs.forum!.data.first.title, 'فرق التجميع عن الكيان؟');
    expect(tabs.resources!.data.first.fileSizeBytes, 2048576);
    expect(tabs.downloads!.data, tabs.resources!.data);
  });

  testWidgets(
    'switches all tabs using response data without additional blocs',
    (tester) async {
      final course = fixture();
      final tabs = course.tabs!;
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(428, 926),
          builder: (_, _) => MaterialApp(
            home: DefaultTabController(
              length: 6,
              child: Scaffold(
                appBar: AppBar(
                  bottom: const TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(text: 'Overview'),
                      Tab(text: 'Curriculum'),
                      Tab(text: 'Reviews'),
                      Tab(text: 'Forum'),
                      Tab(text: 'Resources'),
                      Tab(text: 'Downloads'),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    AboutTab(
                      description: course.description,
                      overview: tabs.overview,
                    ),
                    LessonsTab(sections: tabs.curriculum!.data),
                    ReviewsTab(reviews: tabs.reviews),
                    ForumTab(forum: tabs.forum),
                    ResourcesTab(resources: tabs.resources),
                    DownloadedTab(downloads: tabs.downloads),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('أحمد الخطيب'), findsOneWidget);
      final controller = DefaultTabController.of(
        tester.element(find.byType(TabBar)),
      );
      final expected = [
        'المجمّعات والحدود',
        'دورة ممتازة للمبتدئين، الشرح واضح والأمثلة عملية.',
        'فرق التجميع عن الكيان؟',
        'شرائح الدورة',
        'شرائح الدورة',
      ];
      for (var index = 1; index < 6; index++) {
        controller.animateTo(index);
        await tester.pumpAndSettle();
        expect(find.text(expected[index - 1]), findsOneWidget);
        expect(tester.takeException(), isNull);
      }
    },
  );

  testWidgets('inaccessible tabs hide their embedded contents', (tester) async {
    final json =
        jsonDecode(
              File(
                'test/course_details/fixtures/course_details.json',
              ).readAsStringSync(),
            )
            as Map<String, dynamic>;
    final tabs = json['tabs'] as Map<String, dynamic>;
    (tabs['reviews'] as Map<String, dynamic>)['accessible'] = false;
    final course = CourseDetailsModel.fromJson(json);
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(428, 926),
        builder: (_, _) => MaterialApp(
          home: Scaffold(body: ReviewsTab(reviews: course.tabs!.reviews)),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Reviews are not available.'), findsOneWidget);
    expect(
      find.text('دورة ممتازة للمبتدئين، الشرح واضح والأمثلة عملية.'),
      findsNothing,
    );
  });
}
