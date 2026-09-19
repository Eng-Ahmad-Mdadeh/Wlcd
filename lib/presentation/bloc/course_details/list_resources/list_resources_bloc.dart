import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/course_details/course_details_model.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'list_resources_event.dart';
part 'list_resources_state.dart';

class ListResourcesBloc extends Bloc<IListResourcesEvent, IListResourcesState> {
  ListResourcesBloc() : super(const ListResourcesInitial()) {
    on<LoadListResourcesEvent>(_load);
  }

  FutureOr<void> _load(
    LoadListResourcesEvent event,
    Emitter<IListResourcesState> emit,
  ) async {
    emit(const ListResourcesLoading());
    try {
      final usecase = locator<IUseCase<BaseModel<ContractJsonModel>?, CourseDetailsEntity>>(
        instanceName: 'ListResources',
      );
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(ListResourcesFailed(failure.message)),
        (value) => emit(ListResourcesLoaded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(ListResourcesFailed(error.toString()));
    }
  }
}
