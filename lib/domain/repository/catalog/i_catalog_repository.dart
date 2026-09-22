import 'package:dartz/dartz.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/catalog/categories/categories_model.dart';
import 'package:wlcd/data/model/catalog/banners/banners_model.dart';
import 'package:wlcd/data/model/catalog/course_filters/course_filters_model.dart';
import 'package:wlcd/data/model/catalog/courses/courses_model.dart';
import 'package:wlcd/data/model/catalog/global_platforms/global_platforms_model.dart';
import 'package:wlcd/data/model/catalog/recommendations/recommendations_model.dart';
import 'package:wlcd/domain/entity/catalog/get_featured_courses_entity.dart';

abstract interface class ICatalogRepository {
  Future<Either<AppException, BaseModel<CategoriesModel>?>> listCategories();

  Future<Either<AppException, BaseModel<CoursesModel>?>> getFeaturedCourses(
    GetFeaturedCoursesEntity entity,
  );

  Future<Either<AppException, BaseModel<RecommendationsModel>?>>
  getRecommendedCourses();

  Future<Either<AppException, BaseModel<BannersModel>?>> getBanners();

  Future<Either<AppException, BaseModel<GlobalPlatformsModel>?>>
  getGlobalPlatforms();

  Future<Either<AppException, BaseModel<CourseFiltersModel>?>>
  getCourseFilters();
}
