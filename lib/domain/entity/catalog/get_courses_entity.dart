import 'package:equatable/equatable.dart';

class GetCoursesEntity extends Equatable {
  const GetCoursesEntity({
    this.q,
    this.categoryId,
    this.tagIds = const [],
    this.difficulty,
    this.language,
    this.isFree,
    this.priceMin,
    this.priceMax,
    this.currency,
    this.sort,
    this.cursor,
    this.limit = 20,
  }) : assert(
         priceMin == null || priceMax == null || priceMax >= priceMin,
         'priceMax must be greater than or equal to priceMin',
       ),
       assert(limit > 0, 'limit must be greater than zero');

  final String? q;
  final String? categoryId;
  final List<String> tagIds;
  final String? difficulty;
  final String? language;
  final bool? isFree;
  final num? priceMin;
  final num? priceMax;
  final String? currency;
  final String? sort;
  final String? cursor;
  final int limit;

  static const _unset = Object();

  GetCoursesEntity copyWith({
    Object? q = _unset,
    Object? categoryId = _unset,
    List<String>? tagIds,
    Object? difficulty = _unset,
    Object? language = _unset,
    Object? isFree = _unset,
    Object? priceMin = _unset,
    Object? priceMax = _unset,
    Object? currency = _unset,
    Object? sort = _unset,
    Object? cursor = _unset,
    int? limit,
  }) => GetCoursesEntity(
    q: identical(q, _unset) ? this.q : q as String?,
    categoryId: identical(categoryId, _unset)
        ? this.categoryId
        : categoryId as String?,
    tagIds: tagIds ?? this.tagIds,
    difficulty: identical(difficulty, _unset)
        ? this.difficulty
        : difficulty as String?,
    language: identical(language, _unset) ? this.language : language as String?,
    isFree: identical(isFree, _unset) ? this.isFree : isFree as bool?,
    priceMin: identical(priceMin, _unset) ? this.priceMin : priceMin as num?,
    priceMax: identical(priceMax, _unset) ? this.priceMax : priceMax as num?,
    currency: identical(currency, _unset) ? this.currency : currency as String?,
    sort: identical(sort, _unset) ? this.sort : sort as String?,
    cursor: identical(cursor, _unset) ? this.cursor : cursor as String?,
    limit: limit ?? this.limit,
  );

  Map<String, dynamic> toQueryParameters() => {
    if (q?.isNotEmpty ?? false) 'q': q,
    if (categoryId?.isNotEmpty ?? false) 'categoryId': categoryId,
    if (tagIds.isNotEmpty) 'tagIds': tagIds.join(','),
    if (difficulty?.isNotEmpty ?? false) 'difficulty': difficulty,
    if (language?.isNotEmpty ?? false) 'language': language,
    if (isFree != null) 'isFree': isFree,
    if (priceMin != null) 'priceMin': priceMin,
    if (priceMax != null) 'priceMax': priceMax,
    if (currency?.isNotEmpty ?? false) 'currency': currency,
    if (sort?.isNotEmpty ?? false) 'sort': sort,
    if (cursor?.isNotEmpty ?? false) 'cursor': cursor,
    'limit': limit,
  };

  @override
  List<Object?> get props => [
    q,
    categoryId,
    tagIds,
    difficulty,
    language,
    isFree,
    priceMin,
    priceMax,
    currency,
    sort,
    cursor,
    limit,
  ];
}
