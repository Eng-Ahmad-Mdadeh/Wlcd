import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/profile/email_identifier/email_identifier_model.dart';
import 'package:wlcd/domain/entity/profile/add_email_identifier_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'add_email_identifier_event.dart';
part 'add_email_identifier_state.dart';

class AddEmailIdentifierBloc
    extends Bloc<IAddEmailIdentifierEvent, IAddEmailIdentifierState> {
  AddEmailIdentifierBloc() : super(AddEmailIdentifierInitial()) {
    on<SubmitAddEmailIdentifierEvent>(_submit);
  }

  FutureOr<void> _submit(
    SubmitAddEmailIdentifierEvent event,
    Emitter<IAddEmailIdentifierState> emit,
  ) async {
    emit(AddEmailIdentifierLoading());
    try {
      final usecase = locator<
        IUseCase<BaseModel<EmailIdentifierModel>?, AddEmailIdentifierEntity>
      >(instanceName: 'AddEmailIdentifier');
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(AddEmailIdentifierFailed(failure.message)),
        (value) => emit(AddEmailIdentifierLoaded(result: value)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(AddEmailIdentifierFailed(error.toString()));
    }
  }
}
