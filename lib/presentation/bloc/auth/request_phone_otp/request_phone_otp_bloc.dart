import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/auth/phone_otp_challenge_model.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/entity/auth/request_phone_otp_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'request_phone_otp_event.dart';
part 'request_phone_otp_state.dart';

class RequestPhoneOtpBloc
    extends Bloc<IRequestPhoneOtpEvent, IRequestPhoneOtpState> {
  RequestPhoneOtpBloc() : super(RequestPhoneOtpInitial()) {
    on<SubmitRequestPhoneOtpEvent>(_requestPhoneOtp);
  }

  FutureOr<void> _requestPhoneOtp(
    SubmitRequestPhoneOtpEvent event,
    Emitter<IRequestPhoneOtpState> emit,
  ) async {
    emit(RequestPhoneOtpLoading());
    try {
      final usecase = locator<
        IUseCase<BaseModel<PhoneOtpChallengeModel>?, RequestPhoneOtpEntity>
      >(instanceName: 'RequestPhoneOtp');
      final result = await usecase(event.entity);
      result.fold(
        (failure) => emit(RequestPhoneOtpFailed(failure.message)),
        (response) => emit(RequestPhoneOtpLoaded(challenge: response)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(RequestPhoneOtpFailed(error.toString()));
    }
  }
}
