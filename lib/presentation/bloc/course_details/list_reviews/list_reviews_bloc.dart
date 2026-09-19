import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/course_details/course_details_model.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'list_reviews_event.dart';
part 'list_reviews_state.dart';

class ListReviewsBloc extends Bloc<IListReviewsEvent, IListReviewsState> {
  ListReviewsBloc() : super(const ListReviewsInitial()) {
    on<LoadListReviewsEvent>(_load);
  }

  FutureOr<void> _load(
    LoadListReviewsEvent event,
    Emitter<IListReviewsState> emit,
  ) async {
    emit(const ListReviewsLoading());
    try {
      final usecase = locator<IUseCase<BaseModel<ContractJsonModel>?, CourseDetailsEntity>>(
        instanceName: 'ListReviews',
      );
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(ListReviewsFailed(failure.message)),
        (value) => emit(ListReviewsLoaded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(ListReviewsFailed(error.toString()));
    }
  }
}
