import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/auth/auth_model.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/entity/auth/register_with_phone_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'register_with_phone_event.dart';
part 'register_with_phone_state.dart';

class RegisterWithPhoneBloc
    extends Bloc<IRegisterWithPhoneEvent, IRegisterWithPhoneState> {
  RegisterWithPhoneBloc() : super(RegisterWithPhoneInitial()) {
    on<SubmitRegisterWithPhoneEvent>(_registerWithPhone);
  }

  FutureOr<void> _registerWithPhone(
    SubmitRegisterWithPhoneEvent event,
    Emitter<IRegisterWithPhoneState> emit,
  ) async {
    emit(RegisterWithPhoneLoading());
    try {
      final usecase = locator<
        IUseCase<BaseModel<AuthModel>?, RegisterWithPhoneEntity>
      >(instanceName: 'RegisterWithPhone');
      final result = await usecase(event.entity);
      result.fold(
        (failure) => emit(RegisterWithPhoneFailed(failure.message)),
        (response) => emit(RegisterWithPhoneLoaded(authModel: response)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(RegisterWithPhoneFailed(error.toString()));
    }
  }
}
