import 'package:equatable/equatable.dart';
class FavoriteMembershipModel extends Equatable {
  const FavoriteMembershipModel({required this.membershipId, required this.favoriteGroupId, required this.courseId, required this.availabilityMark, required this.version, required this.createdAt});

  final String membershipId;
  final String favoriteGroupId;
  final String courseId;
  final String availabilityMark;
  final int version;
  final DateTime createdAt;

  factory FavoriteMembershipModel.fromJson(Map<String, dynamic> json) => FavoriteMembershipModel(
    membershipId: json['membershipId'] as String,
    favoriteGroupId: json['favoriteGroupId'] as String,
    courseId: json['courseId'] as String,
    availabilityMark: json['availabilityMark'] as String,
    version: json['version'] as int,
    createdAt: DateTime.parse(json['createdAt'] as String),
  );

  @override
  List<Object?> get props => [membershipId, favoriteGroupId, courseId, availabilityMark, version, createdAt];
}
