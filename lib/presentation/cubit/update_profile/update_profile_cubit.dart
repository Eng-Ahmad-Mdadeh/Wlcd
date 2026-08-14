import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/data/model/profile/profile_model.dart';
import 'package:wlcd/domain/entity/profile/update_profile_entity.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileEntity> {
  UpdateProfileCubit(ProfileModel profile)
    : super(
        UpdateProfileEntity(
          displayName: profile.displayName,
          email: profile.email,
          phone: profile.phone,
          locale: profile.locale,
          idempotencyKey: _createIdempotencyKey(),
          ifMatch: profile.etag ?? '*',
        ),
      );

  void setDisplayName(String value) {
    emit(state.copyWith(displayName: value));
  }

  void setEmail(String value) {
    emit(state.copyWith(email: value));
  }

  void setPhone(String value) {
    emit(state.copyWith(phone: value));
  }

  void prepareForSubmission() {
    emit(
      state.copyWith(
        displayName: state.displayName?.trim(),
        email: state.email?.trim(),
        phone: state.phone?.trim(),
        idempotencyKey: _createIdempotencyKey(),
      ),
    );
  }

  static String _createIdempotencyKey() =>
      'update-profile-${DateTime.now().microsecondsSinceEpoch}';
}
