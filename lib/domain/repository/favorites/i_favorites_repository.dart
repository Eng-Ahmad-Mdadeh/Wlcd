import 'package:dartz/dartz.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/favorites/favorite_group_model.dart';
import 'package:wlcd/data/model/favorites/favorite_groups_model.dart';
import 'package:wlcd/data/model/favorites/favorite_membership_model.dart';
import 'package:wlcd/data/model/favorites/favorite_memberships_model.dart';
import 'package:wlcd/domain/entity/favorites/favorites_entity.dart';

abstract interface class IFavoritesRepository {
  Future<Either<AppException, BaseModel<FavoriteGroupsModel>?>> listFavoriteGroups();
  Future<Either<AppException, BaseModel<FavoriteGroupModel>?>> createFavoriteGroup(FavoritesEntity entity);
  Future<Either<AppException, BaseModel<FavoriteMembershipsModel>?>> listFavoriteMemberships(FavoritesEntity entity);
  Future<Either<AppException, BaseModel<FavoriteMembershipModel>?>> addFavoriteMembership(FavoritesEntity entity);
}
