import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/catalog/categories/categories_model.dart';
import 'package:wlcd/domain/repository/catalog/i_catalog_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

@Injectable(as: IUseCase<BaseModel<CategoriesModel>?, Null>)
@Named('ListCategories')
class ListCategoriesUsecase
    implements IUseCase<BaseModel<CategoriesModel>?, Null> {
  const ListCategoriesUsecase(this._repository);

  final ICatalogRepository _repository;

  @override
  Future<Either<AppException, BaseModel<CategoriesModel>?>> call(Null data) =>
      _repository.listCategories();
}
