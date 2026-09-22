// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_filters_model.dart';

FilterOptionModel _$FilterOptionModelFromJson(Map<String, dynamic> json) =>
    FilterOptionModel(id: json['id'] as String, label: json['label'] as String);

CourseFiltersModel _$CourseFiltersModelFromJson(Map<String, dynamic> json) =>
    CourseFiltersModel(
      categories: (json['categories'] as List<dynamic>)
          .map((item) => FilterOptionModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as List<dynamic>)
          .map((item) => FilterOptionModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      languages: (json['languages'] as List<dynamic>).cast<String>(),
      currencies: (json['currencies'] as List<dynamic>).cast<String>(),
      priceCurrency: json['priceCurrency'] as String,
      priceMin: json['priceMin'] as String,
      priceMax: json['priceMax'] as String,
      hasFree: json['hasFree'] as bool,
      hasPaid: json['hasPaid'] as bool,
      difficulties: (json['difficulties'] as List<dynamic>).cast<String>(),
      sortOptions: (json['sortOptions'] as List<dynamic>).cast<String>(),
    );
