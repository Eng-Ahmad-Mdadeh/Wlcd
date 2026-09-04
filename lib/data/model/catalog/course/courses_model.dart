import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wlcd/data/model/catalog/course/course_model.dart';

part 'courses_model.g.dart';

@JsonSerializable(createToJson: false)
class CoursesModel extends Equatable {
  const CoursesModel({required this.data, this.pagination});

  final List<CourseModel> data;
  final CatalogPaginationModel? pagination;

  factory CoursesModel.fromJson(Map<String, dynamic> json) =>
      _$CoursesModelFromJson(json);

  @override
  List<Object?> get props => [data, pagination];
}

@JsonSerializable(createToJson: false)
class CatalogPaginationModel extends Equatable {
  const CatalogPaginationModel({this.nextCursor, required this.hasMore});

  final String? nextCursor;
  final bool hasMore;

  factory CatalogPaginationModel.fromJson(Map<String, dynamic> json) =>
      _$CatalogPaginationModelFromJson(json);

  @override
  List<Object?> get props => [nextCursor, hasMore];
}
