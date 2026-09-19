import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/course_details/course_details_model.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'is_favorited_event.dart';
part 'is_favorited_state.dart';

class IsFavoritedBloc extends Bloc<IIsFavoritedEvent, IIsFavoritedState> {
  IsFavoritedBloc() : super(const IsFavoritedInitial()) {
    on<LoadIsFavoritedEvent>(_load);
  }

  FutureOr<void> _load(
    LoadIsFavoritedEvent event,
    Emitter<IIsFavoritedState> emit,
  ) async {
    emit(const IsFavoritedLoading());
    try {
      final usecase = locator<IUseCase<BaseModel<ContractJsonModel>?, CourseDetailsEntity>>(
        instanceName: 'IsFavorited',
      );
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(IsFavoritedFailed(failure.message)),
        (value) => emit(IsFavoritedLoaded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(IsFavoritedFailed(error.toString()));
    }
  }
}
