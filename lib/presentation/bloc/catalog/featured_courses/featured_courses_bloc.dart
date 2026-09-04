import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/catalog/courses/courses_model.dart';
import 'package:wlcd/domain/entity/catalog/get_featured_courses_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'featured_courses_event.dart';
part 'featured_courses_state.dart';

class FeaturedCoursesBloc
    extends Bloc<IFeaturedCoursesEvent, IFeaturedCoursesState> {
  FeaturedCoursesBloc() : super(const FeaturedCoursesInitial()) {
    on<LoadFeaturedCoursesEvent>(_load);
  }

  FutureOr<void> _load(
    LoadFeaturedCoursesEvent event,
    Emitter<IFeaturedCoursesState> emit,
  ) async {
    emit(const FeaturedCoursesLoading());
    try {
      final usecase = locator<
        IUseCase<BaseModel<CoursesModel>?, GetFeaturedCoursesEntity>
      >(instanceName: 'GetFeaturedCourses');
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(FeaturedCoursesFailed(failure.message)),
        (value) => emit(FeaturedCoursesLoaded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(FeaturedCoursesFailed(error.toString()));
    }
  }
}
