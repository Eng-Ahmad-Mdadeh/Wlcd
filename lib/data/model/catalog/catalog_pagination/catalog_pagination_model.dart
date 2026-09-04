import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'catalog_pagination_model.g.dart';

@JsonSerializable(createToJson: false)
class CatalogPaginationModel extends Equatable {
  const CatalogPaginationModel({this.nextCursor, required this.hasMore});

  final String? nextCursor;
  final bool hasMore;

  factory CatalogPaginationModel.fromJson(Map<String, dynamic> json) =>
      _$CatalogPaginationModelFromJson(json);

  @override
  List<Object?> get props => [nextCursor, hasMore];
}
