import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/domain/entity/profile/add_phone_identifier_entity.dart';

class AddPhoneIdentifierCubit extends Cubit<AddPhoneIdentifierEntity> {
  AddPhoneIdentifierCubit()
    : super(
        const AddPhoneIdentifierEntity(
          phone: '',
          challengeId: '',
          otpCode: '',
        ),
      );

  void setPhone(String value) => emit(state.copyWith(phone: value));

  void setChallengeId(String value) => emit(state.copyWith(challengeId: value));

  void setOtpCode(String value) => emit(state.copyWith(otpCode: value));

  void prepareForSubmission() => emit(
    state.copyWith(
      phone: state.phone.trim(),
      challengeId: state.challengeId.trim(),
      otpCode: state.otpCode.trim(),
    ),
  );
}
