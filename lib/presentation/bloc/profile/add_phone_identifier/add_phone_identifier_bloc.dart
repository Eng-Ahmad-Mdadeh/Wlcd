import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/profile/phone_identifier/phone_identifier_model.dart';
import 'package:wlcd/domain/entity/profile/add_phone_identifier_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'add_phone_identifier_event.dart';
part 'add_phone_identifier_state.dart';

class AddPhoneIdentifierBloc
    extends Bloc<IAddPhoneIdentifierEvent, IAddPhoneIdentifierState> {
  AddPhoneIdentifierBloc() : super(AddPhoneIdentifierInitial()) {
    on<SubmitAddPhoneIdentifierEvent>(_submit);
  }

  FutureOr<void> _submit(
    SubmitAddPhoneIdentifierEvent event,
    Emitter<IAddPhoneIdentifierState> emit,
  ) async {
    emit(AddPhoneIdentifierLoading());
    try {
      final usecase = locator<
        IUseCase<BaseModel<PhoneIdentifierModel>?, AddPhoneIdentifierEntity>
      >(instanceName: 'AddPhoneIdentifier');
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(AddPhoneIdentifierFailed(failure.message)),
        (value) => emit(AddPhoneIdentifierLoaded(result: value)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(AddPhoneIdentifierFailed(error.toString()));
    }
  }
}
