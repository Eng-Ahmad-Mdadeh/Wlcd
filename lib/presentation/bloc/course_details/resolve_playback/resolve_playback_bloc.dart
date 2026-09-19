import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/course_details/course_details_model.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'resolve_playback_event.dart';
part 'resolve_playback_state.dart';

class ResolvePlaybackBloc extends Bloc<IResolvePlaybackEvent, IResolvePlaybackState> {
  ResolvePlaybackBloc() : super(const ResolvePlaybackInitial()) {
    on<LoadResolvePlaybackEvent>(_load);
  }

  FutureOr<void> _load(
    LoadResolvePlaybackEvent event,
    Emitter<IResolvePlaybackState> emit,
  ) async {
    emit(const ResolvePlaybackLoading());
    try {
      final usecase = locator<IUseCase<BaseModel<PlaybackModel>?, CourseDetailsEntity>>(
        instanceName: 'ResolvePlayback',
      );
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(ResolvePlaybackFailed(failure.message)),
        (value) => emit(ResolvePlaybackLoaded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(ResolvePlaybackFailed(error.toString()));
    }
  }
}
