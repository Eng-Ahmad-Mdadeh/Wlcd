import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable(createToJson: false)
class CategoryModel extends Equatable {
  const CategoryModel({
    required this.categoryId,
    required this.label,
    required this.version,
    this.parentCategoryId,
    this.children,
  });

  final String categoryId;
  final String label;
  final int version;
  final String? parentCategoryId;
  final List<CategoryModel>? children;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  @override
  List<Object?> get props => [
    categoryId,
    label,
    version,
    parentCategoryId,
    children,
  ];
}
