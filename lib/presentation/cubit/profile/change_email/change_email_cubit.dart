import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/domain/entity/profile/change_email_entity.dart';

class ChangeEmailCubit extends Cubit<ChangeEmailEntity> {
  ChangeEmailCubit({String email = ''})
    : super(ChangeEmailEntity(email: email));

  void setEmail(String value) => emit(state.copyWith(email: value));

  void prepareForSubmission() => emit(state.copyWith(email: state.email.trim()));
}
