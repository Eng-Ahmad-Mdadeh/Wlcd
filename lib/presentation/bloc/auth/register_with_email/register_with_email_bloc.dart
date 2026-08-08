import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/auth/auth_model.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/entity/auth/register_with_email_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'register_with_email_event.dart';
part 'register_with_email_state.dart';

class RegisterWithEmailBloc
    extends Bloc<IRegisterWithEmailEvent, IRegisterWithEmailState> {
  RegisterWithEmailBloc() : super(RegisterWithEmailInitial()) {
    on<SubmitRegisterWithEmailEvent>(_registerWithEmail);
  }

  FutureOr<void> _registerWithEmail(
    SubmitRegisterWithEmailEvent event,
    Emitter<IRegisterWithEmailState> emit,
  ) async {
    emit(RegisterWithEmailLoading());
    try {
      final usecase = locator<
        IUseCase<BaseModel<AuthModel>?, RegisterWithEmailEntity>
      >(instanceName: 'RegisterWithEmail');
      final result = await usecase(event.entity);
      result.fold(
        (failure) => emit(RegisterWithEmailFailed(failure.message)),
        (response) => emit(RegisterWithEmailLoaded(authModel: response)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(RegisterWithEmailFailed(error.toString()));
    }
  }
}
