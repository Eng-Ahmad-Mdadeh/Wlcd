import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination_model.g.dart';

Object? _readCursorValue(Map<dynamic, dynamic> json, String key) =>
    (json['pagination'] as Map<dynamic, dynamic>?)?[key];

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class PaginationModel<T> extends Equatable {
  const PaginationModel({
    this.currentPage,
    this.data,
    this.from,
    this.lastPage,
    this.perPage,
    this.to,
    this.total,
    this.meta,
    this.nextCursor,
    this.previousCursor,
    this.hasMore,
    this.limit,
  });

  @JsonKey(name: 'current_page')
  final num? currentPage;
  final List<T>? data;

  final num? from;

  @JsonKey(name: 'last_page')
  final num? lastPage;

  @JsonKey(name: 'per_page')
  final num? perPage;

  final num? to;
  final num? total;
  final Meta? meta;
  @JsonKey(readValue: _readCursorValue)
  final String? nextCursor;
  @JsonKey(readValue: _readCursorValue)
  final String? previousCursor;
  @JsonKey(readValue: _readCursorValue)
  final bool? hasMore;
  @JsonKey(readValue: _readCursorValue)
  final num? limit;

  PaginationModel<T> copyWith({
    num? currentPage,
    List<T>? data,
    num? from,
    num? lastPage,
    num? perPage,
    num? to,
    num? total,
    Meta? meta,
    String? nextCursor,
    String? previousCursor,
    bool? hasMore,
    num? limit,
  }) {
    return PaginationModel<T>(
      currentPage: currentPage ?? this.currentPage,
      data: data ?? this.data,
      from: from ?? this.from,
      lastPage: lastPage ?? this.lastPage,
      perPage: perPage ?? this.perPage,
      to: to ?? this.to,
      total: total ?? this.total,
      meta: meta ?? this.meta,
      nextCursor: nextCursor ?? this.nextCursor,
      previousCursor: previousCursor ?? this.previousCursor,
      hasMore: hasMore ?? this.hasMore,
      limit: limit ?? this.limit,
    );
  }

  factory PaginationModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$PaginationModelFromJson(json, fromJsonT);

  // Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
  //     _$PaginationModelToJson(this, toJsonT);

  @override
  List<Object?> get props => [
    currentPage,
    data,
    from,
    lastPage,
    perPage,
    to,
    total,
    meta,
    nextCursor,
    previousCursor,
    hasMore,
    limit,
  ];
}

@JsonSerializable(createToJson: false)
class Meta extends Equatable {
  const Meta({
    required this.nextCursor,
  });

  @JsonKey(name: 'next_cursor')
  final String? nextCursor;

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  @override
  List<Object?> get props => [
    nextCursor,
  ];
}
