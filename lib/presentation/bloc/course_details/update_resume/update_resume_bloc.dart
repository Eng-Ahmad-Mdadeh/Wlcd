import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/course_details/course_details_model.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'update_resume_event.dart';
part 'update_resume_state.dart';

class UpdateResumeBloc extends Bloc<IUpdateResumeEvent, IUpdateResumeState> {
  UpdateResumeBloc() : super(const UpdateResumeInitial()) {
    on<LoadUpdateResumeEvent>(_load);
  }

  FutureOr<void> _load(
    LoadUpdateResumeEvent event,
    Emitter<IUpdateResumeState> emit,
  ) async {
    emit(const UpdateResumeLoading());
    try {
      final usecase = locator<IUseCase<BaseModel<ResumePositionModel>?, CourseDetailsEntity>>(
        instanceName: 'UpdateResume',
      );
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(UpdateResumeFailed(failure.message)),
        (value) => emit(UpdateResumeLoaded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(UpdateResumeFailed(error.toString()));
    }
  }
}
