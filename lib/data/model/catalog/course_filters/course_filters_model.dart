import 'package:json_annotation/json_annotation.dart';
import 'package:wlcd/domain/entity/catalog/course_filters/course_filters_entity.dart';

part 'course_filters_model.g.dart';

@JsonSerializable(createToJson: false)
class FilterOptionModel extends FilterOptionEntity {
  const FilterOptionModel({required super.id, required super.label});

  factory FilterOptionModel.fromJson(Map<String, dynamic> json) =>
      _$FilterOptionModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class CourseFiltersModel extends CourseFiltersEntity {
  const CourseFiltersModel({
    required List<FilterOptionModel> super.categories,
    required List<FilterOptionModel> super.tags,
    required super.languages,
    required super.currencies,
    required super.priceCurrency,
    required super.priceMin,
    required super.priceMax,
    required super.hasFree,
    required super.hasPaid,
    required super.difficulties,
    required super.sortOptions,
  });

  factory CourseFiltersModel.fromJson(Map<String, dynamic> json) {
    final normalized = Map<String, dynamic>.from(json)
      ..['categories'] = _normalizeOptions(json['categories'], 'categoryId')
      ..['tags'] = _normalizeOptions(json['tags'], 'tagId');
    return _$CourseFiltersModelFromJson(normalized);
  }

  static List<Map<String, dynamic>> _normalizeOptions(
    Object? value,
    String idKey,
  ) =>
      (value as List<dynamic>)
          .map((item) {
            final option = item as Map<String, dynamic>;
            return {'id': option[idKey], 'label': option['label']};
          })
          .toList();
}
