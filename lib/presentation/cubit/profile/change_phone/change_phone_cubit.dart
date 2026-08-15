import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/domain/entity/profile/change_phone_entity.dart';

class ChangePhoneCubit extends Cubit<ChangePhoneEntity> {
  ChangePhoneCubit({String phone = ''})
    : super(ChangePhoneEntity(phone: phone));

  void setPhone(String value) => emit(state.copyWith(phone: value));

  void prepareForSubmission() => emit(state.copyWith(phone: state.phone.trim()));
}
