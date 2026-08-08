import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/auth/auth_model.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/entity/auth/login_with_otp_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'login_with_otp_event.dart';
part 'login_with_otp_state.dart';

class LoginWithOtpBloc extends Bloc<ILoginWithOtpEvent, ILoginWithOtpState> {
  LoginWithOtpBloc() : super(LoginWithOtpInitial()) {
    on<SubmitLoginWithOtpEvent>(_submit);
  }

  FutureOr<void> _submit(SubmitLoginWithOtpEvent event, Emitter<ILoginWithOtpState> emit) async {
    emit(LoginWithOtpLoading());
    try {
      final usecase = locator<
        IUseCase<BaseModel<AuthModel>?, LoginWithOtpEntity>
      >(instanceName: 'LoginWithOtp');
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(LoginWithOtpFailed(failure.message)),
        (value) => emit(LoginWithOtpLoaded(authModel: value)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(LoginWithOtpFailed(error.toString()));
    }
  }
}
