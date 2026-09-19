import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/course_details/course_details_model.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'start_learning_event.dart';
part 'start_learning_state.dart';

class StartLearningBloc extends Bloc<IStartLearningEvent, IStartLearningState> {
  StartLearningBloc() : super(const StartLearningInitial()) {
    on<LoadStartLearningEvent>(_load);
  }

  FutureOr<void> _load(
    LoadStartLearningEvent event,
    Emitter<IStartLearningState> emit,
  ) async {
    emit(const StartLearningLoading());
    try {
      final usecase = locator<IUseCase<BaseModel<ContractJsonModel>?, CourseDetailsEntity>>(
        instanceName: 'StartLearning',
      );
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(StartLearningFailed(failure.message)),
        (value) => emit(StartLearningLoaded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(StartLearningFailed(error.toString()));
    }
  }
}
