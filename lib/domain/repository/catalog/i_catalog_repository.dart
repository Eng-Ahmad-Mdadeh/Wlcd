import 'package:dartz/dartz.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/catalog/categories/categories_model.dart';
import 'package:wlcd/data/model/catalog/courses/courses_model.dart';
import 'package:wlcd/domain/entity/catalog/get_featured_courses_entity.dart';

abstract interface class ICatalogRepository {
  Future<Either<AppException, BaseModel<CategoriesModel>?>> listCategories();

  Future<Either<AppException, BaseModel<CoursesModel>?>> getFeaturedCourses(
    GetFeaturedCoursesEntity entity,
  );

  Future<Either<AppException, BaseModel<CoursesModel>?>>
  getRecommendedCourses();
}
