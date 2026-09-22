import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/catalog/global_platforms/global_platforms_model.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'global_platforms_event.dart';
part 'global_platforms_state.dart';

class GlobalPlatformsBloc
    extends Bloc<IGlobalPlatformsEvent, IGlobalPlatformsState> {
  GlobalPlatformsBloc() : super(const GlobalPlatformsInitial()) {
    on<LoadGlobalPlatformsEvent>(_load);
  }

  FutureOr<void> _load(
    LoadGlobalPlatformsEvent event,
    Emitter<IGlobalPlatformsState> emit,
  ) async {
    emit(const GlobalPlatformsLoading());
    try {
      final usecase = locator<IUseCase<BaseModel<GlobalPlatformsModel>?, Null>>(
        instanceName: 'GetGlobalPlatforms',
      );
      final response = await usecase(null);
      response.fold(
        (failure) => emit(GlobalPlatformsFailed(failure.message)),
        (value) => emit(GlobalPlatformsLoaded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(GlobalPlatformsFailed(error.toString()));
    }
  }
}
