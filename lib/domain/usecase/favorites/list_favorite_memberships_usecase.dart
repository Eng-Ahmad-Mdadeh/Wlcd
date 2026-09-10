import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/favorites/favorite_memberships_model.dart';
import 'package:wlcd/domain/entity/favorites/favorites_entity.dart';
import 'package:wlcd/domain/repository/favorites/i_favorites_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

@Injectable(as: IUseCase<BaseModel<FavoriteMembershipsModel>?, FavoritesEntity>)
@Named('ListFavoriteMemberships')
class ListFavoriteMembershipsUsecase implements IUseCase<BaseModel<FavoriteMembershipsModel>?, FavoritesEntity> {
  const ListFavoriteMembershipsUsecase(this._repository);
  final IFavoritesRepository _repository;
  @override
  Future<Either<AppException, BaseModel<FavoriteMembershipsModel>?>> call(FavoritesEntity data) => _repository.listFavoriteMemberships(data);
}
