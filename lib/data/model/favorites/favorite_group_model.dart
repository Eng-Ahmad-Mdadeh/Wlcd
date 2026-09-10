import 'package:equatable/equatable.dart';
class FavoriteGroupModel extends Equatable {
  const FavoriteGroupModel({required this.favoriteGroupId, required this.name, required this.groupKind, required this.lifecycleStatus, required this.displayOrder, required this.version, required this.createdAt, required this.updatedAt});

  final String favoriteGroupId;
  final String name;
  final String groupKind;
  final String lifecycleStatus;
  final int displayOrder;
  final int version;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory FavoriteGroupModel.fromJson(Map<String, dynamic> json) => FavoriteGroupModel(
    favoriteGroupId: json['favoriteGroupId'] as String,
    name: json['name'] as String,
    groupKind: json['groupKind'] as String,
    lifecycleStatus: json['lifecycleStatus'] as String,
    displayOrder: json['displayOrder'] as int,
    version: json['version'] as int,
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );

  @override
  List<Object?> get props => [favoriteGroupId, name, groupKind, lifecycleStatus, displayOrder, version, createdAt, updatedAt];
}
