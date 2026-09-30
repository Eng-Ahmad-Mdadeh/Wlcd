import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wlcd/data/model/catalog/course_thumbnail/course_thumbnail_model.dart';

part 'category_model.g.dart';

@JsonSerializable(createToJson: false)
class CategoryModel extends Equatable {
  const CategoryModel({
    required this.categoryId,
    required this.label,
    required this.version,
    this.parentCategoryId,
    this.color,
    this.iconMediaId,
    this.icon,
    this.isInterested = false,
    this.children,
  });

  final String categoryId;
  final String label;
  final int version;
  final String? parentCategoryId;
  final String? color;
  final String? iconMediaId;
  final CourseThumbnailModel? icon;
  @JsonKey(defaultValue: false)
  final bool isInterested;
  final List<CategoryModel>? children;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  @override
  List<Object?> get props => [
    categoryId,
    label,
    version,
    parentCategoryId,
    color,
    iconMediaId,
    icon,
    isInterested,
    children,
  ];
}
