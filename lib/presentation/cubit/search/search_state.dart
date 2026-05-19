import 'package:equatable/equatable.dart';
import 'package:wlcd/presentation/screens/Search/widgets/search_course_data.dart';

class SearchState extends Equatable {
  const SearchState({this.keyword = 'UX Design', this.sort = 'default', this.level = 'all', this.topic, this.minRating, this.viewIndex = 0});
  final String keyword;
  final String sort;
  final String level;
  final String? topic;
  final double? minRating;
  final int viewIndex;

  List<SearchCourseData> get filteredCourses {
    final result = searchCourses.where((course) {
      final searchableText = '${course.title} ${course.category}'.toLowerCase();
      final matchLevel = level == 'all' || course.level == level;
      final matchTopic = topic == null || course.category.toLowerCase() == topic!.toLowerCase();
      final matchRating = minRating == null || course.rating >= minRating!;
      return searchableText.contains(keyword.toLowerCase()) && matchLevel && matchTopic && matchRating;
    }).toList();
    switch (sort) {
      case 'price-low': result.sort((a, b) => a.price.compareTo(b.price)); break;
      case 'price-high': result.sort((a, b) => b.price.compareTo(a.price)); break;
      case 'rating': result.sort((a, b) => b.rating.compareTo(a.rating)); break;
    }
    return result;
  }

  SearchState copyWith({String? keyword, String? sort, String? level, String? topic, bool clearTopic = false, double? minRating, bool clearRating = false, int? viewIndex}) {
    return SearchState(
      keyword: keyword ?? this.keyword,
      sort: sort ?? this.sort,
      level: level ?? this.level,
      topic: clearTopic ? null : (topic ?? this.topic),
      minRating: clearRating ? null : (minRating ?? this.minRating),
      viewIndex: viewIndex ?? this.viewIndex,
    );
  }

  @override
  List<Object?> get props => [keyword, sort, level, topic, minRating, viewIndex];
}
