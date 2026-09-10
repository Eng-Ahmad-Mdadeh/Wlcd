import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/data_sources/favorites/favorites_remote_data_source.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/favorites/favorite_group_model.dart';
import 'package:wlcd/data/model/favorites/favorite_groups_model.dart';
import 'package:wlcd/data/model/favorites/favorite_membership_model.dart';
import 'package:wlcd/data/model/favorites/favorite_memberships_model.dart';
import 'package:wlcd/domain/entity/favorites/favorites_entity.dart';
import 'package:wlcd/domain/repository/favorites/i_favorites_repository.dart';

@Injectable(as: IFavoritesRepository)
class FavoritesRepository implements IFavoritesRepository {
  const FavoritesRepository(this._remoteDataSource);
  final FavoritesRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppException, BaseModel<FavoriteGroupsModel>?>> listFavoriteGroups() => _remoteDataSource.listFavoriteGroups();
  @override
  Future<Either<AppException, BaseModel<FavoriteGroupModel>?>> createFavoriteGroup(FavoritesEntity entity) => _remoteDataSource.createFavoriteGroup(entity);
  @override
  Future<Either<AppException, BaseModel<FavoriteMembershipsModel>?>> listFavoriteMemberships(FavoritesEntity entity) => _remoteDataSource.listFavoriteMemberships(entity);
  @override
  Future<Either<AppException, BaseModel<FavoriteMembershipModel>?>> addFavoriteMembership(FavoritesEntity entity) => _remoteDataSource.addFavoriteMembership(entity);
}
