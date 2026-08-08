import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/auth/verify_email_model.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/entity/auth/verify_email_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'verify_email_event.dart';
part 'verify_email_state.dart';

class VerifyEmailBloc extends Bloc<IVerifyEmailEvent, IVerifyEmailState> {
  VerifyEmailBloc() : super(VerifyEmailInitial()) {
    on<SubmitVerifyEmailEvent>(_verifyEmail);
  }

  FutureOr<void> _verifyEmail(
    SubmitVerifyEmailEvent event,
    Emitter<IVerifyEmailState> emit,
  ) async {
    emit(VerifyEmailLoading());
    try {
      final usecase = locator<
        IUseCase<BaseModel<VerifyEmailModel>?, VerifyEmailEntity>
      >(instanceName: 'VerifyEmail');
      final result = await usecase(event.entity);
      result.fold(
        (failure) => emit(VerifyEmailFailed(failure.message)),
        (response) => emit(VerifyEmailLoaded(verification: response)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(VerifyEmailFailed(error.toString()));
    }
  }
}
