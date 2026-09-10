import 'package:equatable/equatable.dart';

/// API-OP-151 does not define the fields of an item in `data`, so they remain
/// lossless JSON until the backend contract publishes an item schema.
class FavoriteGroupsModel extends Equatable {
  const FavoriteGroupsModel({required this.data});

  final List<Map<String, dynamic>> data;

  factory FavoriteGroupsModel.fromJson(Map<String, dynamic> json) => FavoriteGroupsModel(
    data: (json['data'] as List<dynamic>).map((item) => Map<String, dynamic>.from(item as Map)).toList(growable: false),
  );

  @override
  List<Object?> get props => [data];
}
