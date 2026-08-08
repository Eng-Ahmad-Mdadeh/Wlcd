import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/auth/phone_otp_challenge_model.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/entity/auth/request_login_otp_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'request_login_otp_event.dart';
part 'request_login_otp_state.dart';

class RequestLoginOtpBloc extends Bloc<IRequestLoginOtpEvent, IRequestLoginOtpState> {
  RequestLoginOtpBloc() : super(RequestLoginOtpInitial()) {
    on<SubmitRequestLoginOtpEvent>(_submit);
  }

  FutureOr<void> _submit(SubmitRequestLoginOtpEvent event, Emitter<IRequestLoginOtpState> emit) async {
    emit(RequestLoginOtpLoading());
    try {
      final usecase = locator<
        IUseCase<BaseModel<PhoneOtpChallengeModel>?, RequestLoginOtpEntity>
      >(instanceName: 'RequestLoginOtp');
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(RequestLoginOtpFailed(failure.message)),
        (value) => emit(RequestLoginOtpLoaded(challenge: value)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(RequestLoginOtpFailed(error.toString()));
    }
  }
}
