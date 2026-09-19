import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/course_details/course_details_model.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'get_checkout_quote_event.dart';
part 'get_checkout_quote_state.dart';

class GetCheckoutQuoteBloc extends Bloc<IGetCheckoutQuoteEvent, IGetCheckoutQuoteState> {
  GetCheckoutQuoteBloc() : super(const GetCheckoutQuoteInitial()) {
    on<LoadGetCheckoutQuoteEvent>(_load);
  }

  FutureOr<void> _load(
    LoadGetCheckoutQuoteEvent event,
    Emitter<IGetCheckoutQuoteState> emit,
  ) async {
    emit(const GetCheckoutQuoteLoading());
    try {
      final usecase = locator<IUseCase<BaseModel<ContractJsonModel>?, CourseDetailsEntity>>(
        instanceName: 'GetCheckoutQuote',
      );
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(GetCheckoutQuoteFailed(failure.message)),
        (value) => emit(GetCheckoutQuoteLoaded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(GetCheckoutQuoteFailed(error.toString()));
    }
  }
}
