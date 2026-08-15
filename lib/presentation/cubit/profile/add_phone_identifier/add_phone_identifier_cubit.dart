import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/domain/entity/profile/add_phone_identifier_entity.dart';

class AddPhoneIdentifierCubit extends Cubit<AddPhoneIdentifierEntity> {
  AddPhoneIdentifierCubit() : super(const AddPhoneIdentifierEntity(phone: ''));

  void setPhone(String value) => emit(state.copyWith(phone: value));

  void prepareForSubmission() => emit(state.copyWith(phone: state.phone.trim()));
}
