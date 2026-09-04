import 'package:equatable/equatable.dart';

class GetFeaturedCoursesEntity extends Equatable {
  const GetFeaturedCoursesEntity({this.cursor, this.limit = 10});

  final String? cursor;
  final int limit;

  GetFeaturedCoursesEntity copyWith({
    String? cursor,
    int? limit,
    bool clearCursor = false,
  }) => GetFeaturedCoursesEntity(
    cursor: clearCursor ? null : cursor ?? this.cursor,
    limit: limit ?? this.limit,
  );

  Map<String, dynamic> toQueryParameters() => {
    if (cursor != null) 'cursor': cursor,
    'limit': limit,
  };

  @override
  List<Object?> get props => [cursor, limit];
}
