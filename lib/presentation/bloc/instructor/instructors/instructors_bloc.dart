import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/instructor/instructor_model.dart';
import 'package:wlcd/domain/entity/instructor/get_instructors_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'instructors_event.dart';
part 'instructors_state.dart';

class InstructorsBloc extends Bloc<IInstructorsEvent, IInstructorsState> {
  InstructorsBloc() : super(const InstructorsInitial()) {
    on<LoadInstructorsEvent>(_load);
  }

  FutureOr<void> _load(
    LoadInstructorsEvent event,
    Emitter<IInstructorsState> emit,
  ) async {
    emit(const InstructorsLoading());
    try {
      final usecase = locator<
        IUseCase<BaseModel<InstructorModel>?, GetInstructorsEntity>
      >(instanceName: 'GetInstructors');
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(InstructorsFailed(failure.message)),
        (value) => emit(InstructorsLoaded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(InstructorsFailed(error.toString()));
    }
  }
}
