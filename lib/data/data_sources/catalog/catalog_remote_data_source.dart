import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/constants/api_endpoints.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/data_sources/base/base_remote_data_source.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/catalog/categories/categories_model.dart';
import 'package:wlcd/data/model/catalog/banners/banners_model.dart';
import 'package:wlcd/data/model/catalog/course_filters/course_filters_model.dart';
import 'package:wlcd/data/model/catalog/courses/courses_model.dart';
import 'package:wlcd/data/model/catalog/global_platforms/global_platforms_model.dart';
import 'package:wlcd/data/model/catalog/recommendations/recommendations_model.dart';
import 'package:wlcd/domain/entity/catalog/get_featured_courses_entity.dart';
import 'package:wlcd/domain/entity/catalog/get_courses_entity.dart';

@injectable
class CatalogRemoteDataSource extends BaseRemoteDataSource<Object> {
  CatalogRemoteDataSource() : super('');

  Future<Either<AppException, BaseModel<CategoriesModel>?>> listCategories() => fetchDataAs<CategoriesModel>(
    endpoint: _catalogEndpoint(ApiEndpoints.categories),
    fromJsonT: _categoriesFromJson,
    wrappedResponse: false,
  );

  Future<Either<AppException, BaseModel<CoursesModel>?>> getFeaturedCourses(GetFeaturedCoursesEntity entity) =>
      fetchDataAs<CoursesModel>(
        endpoint: _catalogEndpoint(ApiEndpoints.featuredCourses),
        queryParams: entity.toQueryParameters(),
        fromJsonT: _coursesFromJson,
        wrappedResponse: false,
      );

  Future<Either<AppException, BaseModel<RecommendationsModel>?>> getRecommendedCourses() =>
      fetchDataAs<RecommendationsModel>(
        endpoint: _catalogEndpoint(ApiEndpoints.recommendedCourses),
        fromJsonT: _recommendationsFromJson,
        wrappedResponse: false,
      );

  Future<Either<AppException, BaseModel<BannersModel>?>> getBanners() =>
      fetchDataAs<BannersModel>(
        endpoint: _catalogEndpoint(ApiEndpoints.banners),
        fromJsonT: BannersModel.fromJson,
        wrappedResponse: false,
      );

  Future<Either<AppException, BaseModel<GlobalPlatformsModel>?>>
  getGlobalPlatforms() =>
      fetchDataAs<GlobalPlatformsModel>(
        endpoint: _catalogEndpoint(ApiEndpoints.globalPlatforms),
        fromJsonT: GlobalPlatformsModel.fromJson,
        wrappedResponse: false,
      );

  Future<Either<AppException, BaseModel<CourseFiltersModel>?>>
  getCourseFilters() =>
      fetchDataAs<CourseFiltersModel>(
        endpoint: _catalogEndpoint(ApiEndpoints.courseFilters),
        fromJsonT: _courseFiltersFromJson,
        wrappedResponse: false,
      );

  Future<Either<AppException, BaseModel<CoursesModel>?>> getCourses(
    GetCoursesEntity entity,
  ) => fetchDataAs<CoursesModel>(
    endpoint: ApiEndpoints.courses,
    queryParams: entity.toQueryParameters(),
    fromJsonT: _coursesFromJson,
    wrappedResponse: false,
  );

  static String _catalogEndpoint(String endpoint) =>
      '${ApiEndpoints.catalog}$endpoint';

  static CategoriesModel _categoriesFromJson(Object? json) => CategoriesModel.fromJson(json as Map<String, dynamic>);

  static CoursesModel _coursesFromJson(Object? json) => CoursesModel.fromJson(json as Map<String, dynamic>);

  static RecommendationsModel _recommendationsFromJson(Object? json) =>
      RecommendationsModel.fromJson(json as Map<String, dynamic>);

  static CourseFiltersModel _courseFiltersFromJson(Object? json) =>
      CourseFiltersModel.fromJson(json as Map<String, dynamic>);
}
