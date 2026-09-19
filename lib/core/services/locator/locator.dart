
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/services/locator/locator.config.dart';
import 'package:wlcd/data/data_sources/course_details/course_details_remote_data_source.dart';
import 'package:wlcd/data/repository/course_details/course_details_repository.dart';
import 'package:wlcd/domain/repository/course_details/i_course_details_repository.dart';
import 'package:wlcd/domain/usecase/course_details/course_details_usecase.dart';


final locator = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() {
  locator.init();
  // Keep this feature usable when the checked-in Injectable output has not yet
  // been regenerated. The guards make this compatible with future generation.
  if (!locator.isRegistered<CourseDetailsRemoteDataSource>()) {
    locator.registerFactory(CourseDetailsRemoteDataSource.new);
  }
  if (!locator.isRegistered<ICourseDetailsRepository>()) {
    locator.registerFactory<ICourseDetailsRepository>(
      () => CourseDetailsRepository(locator<CourseDetailsRemoteDataSource>()),
    );
  }
  if (!locator.isRegistered<CourseDetailsUsecase>()) {
    locator.registerFactory(
      () => CourseDetailsUsecase(locator<ICourseDetailsRepository>()),
    );
  }
}
