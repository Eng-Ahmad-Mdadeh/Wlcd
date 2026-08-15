import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/domain/entity/profile/add_email_identifier_entity.dart';

class AddEmailIdentifierCubit extends Cubit<AddEmailIdentifierEntity> {
  AddEmailIdentifierCubit() : super(const AddEmailIdentifierEntity(email: ''));

  void setEmail(String value) => emit(state.copyWith(email: value));

  void prepareForSubmission() => emit(state.copyWith(email: state.email.trim()));
}
