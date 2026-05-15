import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination_model.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class PaginationModel<T> extends Equatable {
  const PaginationModel({
    required this.currentPage,
    required this.data,
    required this.from,
    required this.lastPage,
    required this.perPage,
    required this.to,
    required this.total,
    required this.meta,
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

  PaginationModel<T> copyWith({
    num? currentPage,
    List<T>? data,
    num? from,
    num? lastPage,
    num? perPage,
    num? to,
    num? total,
    Meta? meta,
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
