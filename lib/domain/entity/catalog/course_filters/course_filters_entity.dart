import 'package:equatable/equatable.dart';

class FilterOptionEntity extends Equatable {
  const FilterOptionEntity({required this.id, required this.label});

  final String id;
  final String label;

  @override
  List<Object?> get props => [id, label];
}

class CourseFiltersEntity extends Equatable {
  const CourseFiltersEntity({
    required this.categories,
    required this.tags,
    required this.languages,
    required this.currencies,
    required this.priceCurrency,
    required this.priceMin,
    required this.priceMax,
    required this.hasFree,
    required this.hasPaid,
    required this.difficulties,
    required this.sortOptions,
  });

  final List<FilterOptionEntity> categories;
  final List<FilterOptionEntity> tags;
  final List<String> languages;
  final List<String> currencies;
  final String priceCurrency;
  final String priceMin;
  final String priceMax;
  final bool hasFree;
  final bool hasPaid;
  final List<String> difficulties;
  final List<String> sortOptions;

  @override
  List<Object?> get props => [
    categories,
    tags,
    languages,
    currencies,
    priceCurrency,
    priceMin,
    priceMax,
    hasFree,
    hasPaid,
    difficulties,
    sortOptions,
  ];
}
