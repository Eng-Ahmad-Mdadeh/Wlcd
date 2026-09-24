import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/instructor/instructor_model.dart';
import 'package:wlcd/domain/entity/instructor/get_instructor_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'instructor_event.dart';
part 'instructor_state.dart';

class InstructorBloc extends Bloc<IInstructorEvent, IInstructorState> {
  InstructorBloc() : super(const InstructorInitial()) {
    on<LoadInstructorEvent>(_load);
  }

  FutureOr<void> _load(
    LoadInstructorEvent event,
    Emitter<IInstructorState> emit,
  ) async {
    emit(const InstructorLoading());
    try {
      final usecase = locator<
        IUseCase<BaseModel<InstructorModel>?, GetInstructorEntity>
      >(instanceName: 'GetInstructor');
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(InstructorFailed(failure.message)),
        (value) => emit(InstructorLoaded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(InstructorFailed(error.toString()));
    }
  }
}
