import 'package:equatable/equatable.dart';

class GetInstructorsEntity extends Equatable {
  const GetInstructorsEntity({
    this.q,
    this.categoryId,
    this.categoryIds = const [],
    this.sort,
    this.cursor,
    this.limit = 5,
  }) : assert(limit > 0, 'limit must be greater than zero');

  final String? q;
  final String? categoryId;
  final List<String> categoryIds;
  final String? sort;
  final String? cursor;
  final int limit;

  Map<String, dynamic> toQueryParameters() => {
    if (q?.isNotEmpty ?? false) 'q': q,
    if (categoryId?.isNotEmpty ?? false) 'categoryId': categoryId,
    if (categoryIds.isNotEmpty) 'categoryIds': categoryIds,
    if (sort?.isNotEmpty ?? false) 'sort': sort,
    if (cursor?.isNotEmpty ?? false) 'cursor': cursor,
    'limit': limit,
  };

  GetInstructorsEntity copyWith({
    String? q,
    String? categoryId,
    List<String>? categoryIds,
    String? sort,
    String? cursor,
    int? limit,
    bool clearQ = false,
    bool clearCategoryId = false,
    bool clearSort = false,
    bool clearCursor = false,
  }) => GetInstructorsEntity(
    q: clearQ ? null : q ?? this.q,
    categoryId: clearCategoryId ? null : categoryId ?? this.categoryId,
    categoryIds: categoryIds ?? this.categoryIds,
    sort: clearSort ? null : sort ?? this.sort,
    cursor: clearCursor ? null : cursor ?? this.cursor,
    limit: limit ?? this.limit,
  );

  @override
  List<Object?> get props => [q, categoryId, categoryIds, sort, cursor, limit];
}
