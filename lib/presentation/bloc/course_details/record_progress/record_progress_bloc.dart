import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/course_details/course_details_model.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'record_progress_event.dart';
part 'record_progress_state.dart';

class RecordProgressBloc extends Bloc<IRecordProgressEvent, IRecordProgressState> {
  RecordProgressBloc() : super(const RecordProgressInitial()) {
    on<LoadRecordProgressEvent>(_load);
  }

  FutureOr<void> _load(
    LoadRecordProgressEvent event,
    Emitter<IRecordProgressState> emit,
  ) async {
    emit(const RecordProgressLoading());
    try {
      final usecase = locator<IUseCase<BaseModel<ProgressEventModel>?, CourseDetailsEntity>>(
        instanceName: 'RecordProgress',
      );
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(RecordProgressFailed(failure.message)),
        (value) => emit(RecordProgressLoaded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(RecordProgressFailed(error.toString()));
    }
  }
}
