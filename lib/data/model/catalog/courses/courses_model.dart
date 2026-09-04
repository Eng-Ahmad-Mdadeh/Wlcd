import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wlcd/data/model/catalog/catalog_pagination/catalog_pagination_model.dart';
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
