import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/auth/auth_model.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/entity/auth/register_with_email_entity.dart';
import 'package:wlcd/domain/entity/auth/register_with_phone_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<IRegisterEvent, IRegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterWithEmailEvent>(_registerWithEmail);
    on<RegisterWithPhoneEvent>(_registerWithPhone);
  }

  FutureOr<void> _registerWithEmail(
    RegisterWithEmailEvent event,
    Emitter<IRegisterState> emit,
  ) async {
    emit(RegisterLoading());
    try {
      final usecase = locator<
        IUseCase<BaseModel<AuthModel>?, RegisterWithEmailEntity>
      >(instanceName: 'RegisterWithEmail');
      final result = await usecase(event.entity);
      result.fold(
        (failure) => emit(RegisterFailed(failure.message)),
        (response) => emit(RegisterLoaded(authModel: response)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(RegisterFailed(error.toString()));
    }
  }

  FutureOr<void> _registerWithPhone(
    RegisterWithPhoneEvent event,
    Emitter<IRegisterState> emit,
  ) async {
    emit(RegisterLoading());
    try {
      final usecase = locator<
        IUseCase<BaseModel<AuthModel>?, RegisterWithPhoneEntity>
      >(instanceName: 'RegisterWithPhone');
      final result = await usecase(event.entity);
      result.fold(
        (failure) => emit(RegisterFailed(failure.message)),
        (response) => emit(RegisterLoaded(authModel: response)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(RegisterFailed(error.toString()));
    }
  }
}
