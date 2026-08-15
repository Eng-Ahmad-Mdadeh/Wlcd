import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/domain/entity/profile/change_phone_entity.dart';

class ChangePhoneCubit extends Cubit<ChangePhoneEntity> {
  ChangePhoneCubit({String phone = ''})
    : super(
        ChangePhoneEntity(
          newPhone: phone,
          challengeId: '',
          otpCode: '',
        ),
      );

  void setPhone(String value) => emit(state.copyWith(newPhone: value));

  void setChallengeId(String value) => emit(state.copyWith(challengeId: value));

  void setOtpCode(String value) => emit(state.copyWith(otpCode: value));

  void prepareForSubmission() => emit(
    state.copyWith(
      newPhone: state.newPhone.trim(),
      challengeId: state.challengeId.trim(),
      otpCode: state.otpCode.trim(),
    ),
  );
}
