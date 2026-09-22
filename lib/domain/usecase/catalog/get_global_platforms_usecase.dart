import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/catalog/global_platforms/global_platforms_model.dart';
import 'package:wlcd/domain/repository/catalog/i_catalog_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

@Injectable(as: IUseCase<BaseModel<GlobalPlatformsModel>?, Null>)
@Named('GetGlobalPlatforms')
class GetGlobalPlatformsUsecase implements IUseCase<BaseModel<GlobalPlatformsModel>?, Null> {
  const GetGlobalPlatformsUsecase(this._repository);

  final ICatalogRepository _repository;

  @override
  Future<Either<AppException, BaseModel<GlobalPlatformsModel>?>> call(Null data) =>
      _repository.getGlobalPlatforms();
}
