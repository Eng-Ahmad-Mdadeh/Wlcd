import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/profile/profile/profile_model.dart';
import 'package:wlcd/domain/entity/profile/update_profile_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'update_profile_event.dart';

part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<IUpdateProfileEvent, IUpdateProfileState> {
  UpdateProfileBloc() : super(UpdateProfileInitial()) {
    on<SubmitUpdateProfileEvent>(_submit);
  }

  FutureOr<void> _submit(SubmitUpdateProfileEvent event, Emitter<IUpdateProfileState> emit) async {
    emit(UpdateProfileLoading());
    try {
      final usecase = locator<IUseCase<BaseModel<ProfileModel>?, UpdateProfileEntity>>(instanceName: 'UpdateProfile');
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(UpdateProfileFailed(failure.message)),
        (value) => emit(UpdateProfileLoaded(profileModel: value)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(UpdateProfileFailed(error.toString()));
    }
  }
}
