import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/data_sources/catalog/catalog_remote_data_source.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/catalog/categories/categories_model.dart';
import 'package:wlcd/data/model/catalog/banners/banners_model.dart';
import 'package:wlcd/data/model/catalog/course_filters/course_filters_model.dart';
import 'package:wlcd/data/model/catalog/courses/courses_model.dart';
import 'package:wlcd/data/model/catalog/global_platforms/global_platforms_model.dart';
import 'package:wlcd/data/model/catalog/recommendations/recommendations_model.dart';
import 'package:wlcd/domain/entity/catalog/get_featured_courses_entity.dart';
import 'package:wlcd/domain/entity/catalog/get_courses_entity.dart';
import 'package:wlcd/domain/repository/catalog/i_catalog_repository.dart';

@Injectable(as: ICatalogRepository)
class CatalogRepository implements ICatalogRepository {
  const CatalogRepository(this._remoteDataSource);

  final CatalogRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppException, BaseModel<CategoriesModel>?>> listCategories() =>
      _remoteDataSource.listCategories();

  @override
  Future<Either<AppException, BaseModel<CoursesModel>?>> getFeaturedCourses(
    GetFeaturedCoursesEntity entity,
  ) => _remoteDataSource.getFeaturedCourses(entity);

  @override
  Future<Either<AppException, BaseModel<RecommendationsModel>?>>
  getRecommendedCourses() => _remoteDataSource.getRecommendedCourses();

  @override
  Future<Either<AppException, BaseModel<BannersModel>?>> getBanners() =>
      _remoteDataSource.getBanners();

  @override
  Future<Either<AppException, BaseModel<GlobalPlatformsModel>?>>
  getGlobalPlatforms() => _remoteDataSource.getGlobalPlatforms();

  @override
  Future<Either<AppException, BaseModel<CourseFiltersModel>?>>
  getCourseFilters() => _remoteDataSource.getCourseFilters();

  @override
  Future<Either<AppException, BaseModel<CoursesModel>?>> getCourses(
    GetCoursesEntity entity,
  ) => _remoteDataSource.getCourses(entity);
}
