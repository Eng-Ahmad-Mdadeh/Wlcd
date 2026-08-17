// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      categoryId: json['categoryId'] as String,
      label: json['label'] as String,
      version: (json['version'] as num).toInt(),
      parentCategoryId: json['parentCategoryId'] as String?,
      children: (json['children'] as List<dynamic>?)
          ?.map((item) => CategoryModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
