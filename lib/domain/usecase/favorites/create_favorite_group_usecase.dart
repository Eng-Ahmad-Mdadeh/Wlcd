import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/favorites/favorite_group_model.dart';
import 'package:wlcd/domain/entity/favorites/favorites_entity.dart';
import 'package:wlcd/domain/repository/favorites/i_favorites_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

@Injectable(as: IUseCase<BaseModel<FavoriteGroupModel>?, FavoritesEntity>)
@Named('CreateFavoriteGroup')
class CreateFavoriteGroupUsecase implements IUseCase<BaseModel<FavoriteGroupModel>?, FavoritesEntity> {
  const CreateFavoriteGroupUsecase(this._repository);
  final IFavoritesRepository _repository;
  @override
  Future<Either<AppException, BaseModel<FavoriteGroupModel>?>> call(FavoritesEntity data) => _repository.createFavoriteGroup(data);
}
