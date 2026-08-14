import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/profile/profile_model.dart';
import 'package:wlcd/domain/entity/profile/upload_avatar_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'upload_avatar_event.dart';
part 'upload_avatar_state.dart';

class UploadAvatarBloc extends Bloc<IUploadAvatarEvent, IUploadAvatarState> {
  UploadAvatarBloc() : super(UploadAvatarInitial()) {
    on<SubmitUploadAvatarEvent>(_submit);
  }

  FutureOr<void> _submit(
    SubmitUploadAvatarEvent event,
    Emitter<IUploadAvatarState> emit,
  ) async {
    emit(UploadAvatarLoading());
    try {
      final usecase = locator<
        IUseCase<BaseModel<ProfileModel>?, UploadAvatarEntity>
      >(instanceName: 'UploadAvatar');
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(UploadAvatarFailed(failure.message)),
        (value) => emit(UploadAvatarLoaded(profileModel: value)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(UploadAvatarFailed(error.toString()));
    }
  }
}
