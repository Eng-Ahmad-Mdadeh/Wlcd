import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/profile/profile/profile_model.dart';
import 'package:wlcd/domain/entity/profile/complete_profile_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'complete_profile_event.dart';
part 'complete_profile_state.dart';

class CompleteProfileBloc extends Bloc<ICompleteProfileEvent, ICompleteProfileState> {
  CompleteProfileBloc() : super(CompleteProfileInitial()) {
    on<SubmitCompleteProfileEvent>(_submit);
  }

  FutureOr<void> _submit(
    SubmitCompleteProfileEvent event,
    Emitter<ICompleteProfileState> emit,
  ) async {
    emit(CompleteProfileLoading());
    try {
      final usecase = locator<
        IUseCase<BaseModel<ProfileModel>?, CompleteProfileEntity>
      >(instanceName: 'CompleteProfile');
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(CompleteProfileFailed(failure.message)),
        (value) => emit(CompleteProfileLoaded(profileModel: value)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(CompleteProfileFailed(error.toString()));
    }
  }
}
