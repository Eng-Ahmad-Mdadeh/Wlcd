import 'package:equatable/equatable.dart';

class FavoritesEntity extends Equatable {
  const FavoritesEntity({this.favoriteGroupId, this.courseId, this.name, this.idempotencyKey});

  final String? favoriteGroupId;
  final String? courseId;
  final String? name;
  final String? idempotencyKey;

  FavoritesEntity copyWith({String? favoriteGroupId, String? courseId, String? name, String? idempotencyKey, bool clearFavoriteGroupId = false, bool clearCourseId = false}) => FavoritesEntity(
    favoriteGroupId: clearFavoriteGroupId ? null : favoriteGroupId ?? this.favoriteGroupId,
    courseId: clearCourseId ? null : courseId ?? this.courseId,
    name: name ?? this.name,
    idempotencyKey: idempotencyKey ?? this.idempotencyKey,
  );

  Map<String, dynamic> createGroupBody() => {'name': name};
  Map<String, dynamic> addMembershipBody() => {'courseId': courseId};

  @override
  List<Object?> get props => [favoriteGroupId, courseId, name, idempotencyKey];
}
