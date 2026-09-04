import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/profile/email_identifier/email_identifier_model.dart';
import 'package:wlcd/domain/entity/profile/change_email_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'change_email_event.dart';
part 'change_email_state.dart';

class ChangeEmailBloc extends Bloc<IChangeEmailEvent, IChangeEmailState> {
  ChangeEmailBloc() : super(ChangeEmailInitial()) {
    on<SubmitChangeEmailEvent>(_submit);
  }

  FutureOr<void> _submit(
    SubmitChangeEmailEvent event,
    Emitter<IChangeEmailState> emit,
  ) async {
    emit(ChangeEmailLoading());
    try {
      final usecase = locator<
        IUseCase<BaseModel<EmailIdentifierModel>?, ChangeEmailEntity>
      >(instanceName: 'ChangeEmail');
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(ChangeEmailFailed(failure.message)),
        (value) => emit(ChangeEmailLoaded(result: value)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(ChangeEmailFailed(error.toString()));
    }
  }
}
