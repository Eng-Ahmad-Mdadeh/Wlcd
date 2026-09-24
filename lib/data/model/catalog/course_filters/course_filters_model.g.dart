// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_filters_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterOptionModel _$FilterOptionModelFromJson(Map<String, dynamic> json) =>
    FilterOptionModel(id: json['id'] as String, label: json['label'] as String);

CourseFiltersModel _$CourseFiltersModelFromJson(Map<String, dynamic> json) =>
    CourseFiltersModel(
      categories: (json['categories'] as List<dynamic>)
          .map((e) => FilterOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as List<dynamic>)
          .map((e) => FilterOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      languages: (json['languages'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      currencies: (json['currencies'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      priceCurrency: json['priceCurrency'] as String,
      priceMin: json['priceMin'] as String,
      priceMax: json['priceMax'] as String,
      hasFree: json['hasFree'] as bool,
      hasPaid: json['hasPaid'] as bool,
      difficulties: (json['difficulties'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      sortOptions: (json['sortOptions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );
