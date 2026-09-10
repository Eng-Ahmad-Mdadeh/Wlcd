import 'package:equatable/equatable.dart';

/// API-OP-155 only specifies the containing fields, not membership item fields.
class FavoriteMembershipsModel extends Equatable {
  const FavoriteMembershipsModel({required this.favoriteGroupId, required this.data});

  final String favoriteGroupId;
  final List<Map<String, dynamic>> data;

  factory FavoriteMembershipsModel.fromJson(Map<String, dynamic> json) => FavoriteMembershipsModel(
    favoriteGroupId: json['favoriteGroupId'] as String,
    data: (json['data'] as List<dynamic>).map((item) => Map<String, dynamic>.from(item as Map)).toList(growable: false),
  );

  @override
  List<Object?> get props => [favoriteGroupId, data];
}
