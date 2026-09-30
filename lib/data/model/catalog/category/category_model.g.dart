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
      color: json['color'] as String?,
      iconMediaId: json['iconMediaId'] as String?,
      icon: json['icon'] == null
          ? null
          : CourseThumbnailModel.fromJson(json['icon'] as Map<String, dynamic>),
      isInterested: json['isInterested'] as bool? ?? false,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
