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
