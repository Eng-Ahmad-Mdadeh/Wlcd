import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/favorites/favorite_membership_model.dart';
import 'package:wlcd/domain/entity/favorites/favorites_entity.dart';
import 'package:wlcd/domain/repository/favorites/i_favorites_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

@Injectable(as: IUseCase<BaseModel<FavoriteMembershipModel>?, FavoritesEntity>)
@Named('AddFavoriteMembership')
class AddFavoriteMembershipUsecase implements IUseCase<BaseModel<FavoriteMembershipModel>?, FavoritesEntity> {
  const AddFavoriteMembershipUsecase(this._repository);
  final IFavoritesRepository _repository;
  @override
  Future<Either<AppException, BaseModel<FavoriteMembershipModel>?>> call(FavoritesEntity data) => _repository.addFavoriteMembership(data);
}
