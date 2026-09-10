import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/favorites/favorite_groups_model.dart';
import 'package:wlcd/domain/repository/favorites/i_favorites_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

@Injectable(as: IUseCase<BaseModel<FavoriteGroupsModel>?, Null>)
@Named('ListFavoriteGroups')
class ListFavoriteGroupsUsecase implements IUseCase<BaseModel<FavoriteGroupsModel>?, Null> {
  const ListFavoriteGroupsUsecase(this._repository);
  final IFavoritesRepository _repository;
  @override
  Future<Either<AppException, BaseModel<FavoriteGroupsModel>?>> call(Null data) => _repository.listFavoriteGroups();
}
