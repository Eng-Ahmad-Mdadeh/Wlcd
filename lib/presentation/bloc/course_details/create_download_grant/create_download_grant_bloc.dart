import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/course_details/course_details_model.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'create_download_grant_event.dart';
part 'create_download_grant_state.dart';

class CreateDownloadGrantBloc extends Bloc<ICreateDownloadGrantEvent, ICreateDownloadGrantState> {
  CreateDownloadGrantBloc() : super(const CreateDownloadGrantInitial()) {
    on<LoadCreateDownloadGrantEvent>(_load);
  }

  FutureOr<void> _load(
    LoadCreateDownloadGrantEvent event,
    Emitter<ICreateDownloadGrantState> emit,
  ) async {
    emit(const CreateDownloadGrantLoading());
    try {
      final usecase = locator<IUseCase<BaseModel<DownloadGrantModel>?, CourseDetailsEntity>>(
        instanceName: 'CreateDownloadGrant',
      );
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(CreateDownloadGrantFailed(failure.message)),
        (value) => emit(CreateDownloadGrantLoaded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(CreateDownloadGrantFailed(error.toString()));
    }
  }
}
