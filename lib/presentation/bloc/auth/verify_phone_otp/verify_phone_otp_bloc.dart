import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/auth/phone_otp_verification_model.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/entity/auth/verify_phone_otp_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'verify_phone_otp_event.dart';

part 'verify_phone_otp_state.dart';

class VerifyPhoneOtpBloc extends Bloc<IVerifyPhoneOtpEvent, IVerifyPhoneOtpState> {
  VerifyPhoneOtpBloc() : super(VerifyPhoneOtpInitial()) {
    on<SubmitVerifyPhoneOtpEvent>(_submit);
  }

  FutureOr<void> _submit(SubmitVerifyPhoneOtpEvent event, Emitter<IVerifyPhoneOtpState> emit) async {
    emit(VerifyPhoneOtpLoading());
    try {
      final usecase = locator<IUseCase<BaseModel<PhoneOtpVerificationModel>?, VerifyPhoneOtpEntity>>(
        instanceName: 'VerifyPhoneOtp',
      );
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(VerifyPhoneOtpFailed(failure.message)),
        (value) => emit(VerifyPhoneOtpLoaded(verification: value)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(VerifyPhoneOtpFailed(error.toString()));
    }
  }
}
