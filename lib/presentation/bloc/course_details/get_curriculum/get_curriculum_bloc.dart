import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/course_details/course_details_model.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'get_curriculum_event.dart';
part 'get_curriculum_state.dart';

class GetCurriculumBloc extends Bloc<IGetCurriculumEvent, IGetCurriculumState> {
  GetCurriculumBloc() : super(const GetCurriculumInitial()) {
    on<LoadGetCurriculumEvent>(_load);
  }

  FutureOr<void> _load(
    LoadGetCurriculumEvent event,
    Emitter<IGetCurriculumState> emit,
  ) async {
    emit(const GetCurriculumLoading());
    try {
      final usecase = locator<IUseCase<BaseModel<CurriculumModel>?, CourseDetailsEntity>>(
        instanceName: 'GetCurriculum',
      );
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(GetCurriculumFailed(failure.message)),
        (value) => emit(GetCurriculumLoaded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(GetCurriculumFailed(error.toString()));
    }
  }
}
