import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/constants/api_endpoints.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/data_sources/base/base_remote_data_source.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/favorites/favorite_group_model.dart';
import 'package:wlcd/data/model/favorites/favorite_groups_model.dart';
import 'package:wlcd/data/model/favorites/favorite_membership_model.dart';
import 'package:wlcd/data/model/favorites/favorite_memberships_model.dart';
import 'package:wlcd/domain/entity/favorites/favorites_entity.dart';

@injectable
class FavoritesRemoteDataSource extends BaseRemoteDataSource<Object> {
  FavoritesRemoteDataSource() : super(ApiEndpoints.accounts);

  Future<Either<AppException, BaseModel<FavoriteGroupsModel>?>> listFavoriteGroups() => fetchDataAs(
    endpoint: ApiEndpoints.favoriteGroups,
    fromJsonT: (json) => FavoriteGroupsModel.fromJson(json as Map<String, dynamic>),
    wrappedResponse: false,
  );

  Future<Either<AppException, BaseModel<FavoriteGroupModel>?>> createFavoriteGroup(FavoritesEntity entity) => postDataAs(
    endpoint: ApiEndpoints.favoriteGroups,
    data: entity.createGroupBody(),
    isFormDate: false,
    headers: {'Idempotency-Key': entity.idempotencyKey},
    fromJsonT: (json) => FavoriteGroupModel.fromJson(json as Map<String, dynamic>),
    wrappedResponse: false,
  );

  Future<Either<AppException, BaseModel<FavoriteMembershipsModel>?>> listFavoriteMemberships(FavoritesEntity entity) => fetchDataAs(
    endpoint: ApiEndpoints.favoriteGroupMemberships(entity.favoriteGroupId!),
    fromJsonT: (json) => FavoriteMembershipsModel.fromJson(json as Map<String, dynamic>),
    wrappedResponse: false,
  );

  Future<Either<AppException, BaseModel<FavoriteMembershipModel>?>> addFavoriteMembership(FavoritesEntity entity) => postDataAs(
    endpoint: ApiEndpoints.favoriteGroupMemberships(entity.favoriteGroupId!),
    data: entity.addMembershipBody(),
    isFormDate: false,
    headers: {'Idempotency-Key': entity.idempotencyKey},
    fromJsonT: (json) => FavoriteMembershipModel.fromJson(json as Map<String, dynamic>),
    wrappedResponse: false,
  );
}
