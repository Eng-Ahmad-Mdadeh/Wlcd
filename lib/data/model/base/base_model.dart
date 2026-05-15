import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_model.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class BaseModel<T> extends Equatable {
  const BaseModel({
    this.success,
    this.message,
    this.code,
    this.isArchived,
    this.data,
  });

  final bool? success;
  final String? message;
  final String? code;
  @JsonKey(name: 'is_archived')
  final bool? isArchived;
  final T? data;

  BaseModel copyWith({
    bool? success,
    String? message,
    String? code,
    bool? isArchived,
    T? data,
  }) {
    return BaseModel(
      success: success ?? this.success,
      message: message ?? this.message,
      code: code ?? this.code,
      isArchived: isArchived ?? this.isArchived,
      data: data ?? this.data,
    );
  }

  factory BaseModel.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseModelFromJson(json, fromJsonT);

  @override
  List<Object?> get props => [
    success,
    message,
    code,
    isArchived,
    data,
  ];
}
