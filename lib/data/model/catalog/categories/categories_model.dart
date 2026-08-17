import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wlcd/data/model/catalog/categories/category_model.dart';

part 'categories_model.g.dart';

@JsonSerializable(createToJson: false)
class CategoriesModel extends Equatable {
  const CategoriesModel({required this.categories});

  final List<CategoryModel> categories;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesModelFromJson(json);

  @override
  List<Object?> get props => [categories];
}
