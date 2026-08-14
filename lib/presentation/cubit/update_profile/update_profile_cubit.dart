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
    emit(_copyWith(displayName: value));
  }

  void setEmail(String value) {
    emit(_copyWith(email: value));
  }

  void setPhone(String value) {
    emit(_copyWith(phone: value));
  }

  void prepareForSubmission() {
    emit(
      _copyWith(
        displayName: state.displayName?.trim(),
        email: state.email?.trim(),
        phone: state.phone?.trim(),
        idempotencyKey: _createIdempotencyKey(),
      ),
    );
  }

  UpdateProfileEntity _copyWith({
    String? displayName,
    String? email,
    String? phone,
    String? idempotencyKey,
  }) {
    return UpdateProfileEntity(
      displayName: displayName ?? state.displayName,
      email: email ?? state.email,
      phone: phone ?? state.phone,
      locale: state.locale,
      idempotencyKey: idempotencyKey ?? state.idempotencyKey,
      ifMatch: state.ifMatch,
    );
  }

  static String _createIdempotencyKey() =>
      'update-profile-${DateTime.now().microsecondsSinceEpoch}';
}
