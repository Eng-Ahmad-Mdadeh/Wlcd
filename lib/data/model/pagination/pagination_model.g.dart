// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationModel<T> _$PaginationModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => PaginationModel<T>(
  currentPage: json['current_page'] as num?,
  data: (json['data'] as List<dynamic>?)?.map(fromJsonT).toList(),
  from: json['from'] as num?,
  lastPage: json['last_page'] as num?,
  perPage: json['per_page'] as num?,
  to: json['to'] as num?,
  total: json['total'] as num?,
  meta: json['meta'] == null
      ? null
      : Meta.fromJson(json['meta'] as Map<String, dynamic>),
);

Meta _$MetaFromJson(Map<String, dynamic> json) =>
    Meta(nextCursor: json['next_cursor'] as String?);
