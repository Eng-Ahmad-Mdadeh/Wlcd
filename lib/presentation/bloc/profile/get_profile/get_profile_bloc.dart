import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/profile/profile_model.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'get_profile_event.dart';
part 'get_profile_state.dart';

class GetProfileBloc extends Bloc<IGetProfileEvent, IGetProfileState> {
  GetProfileBloc() : super(GetProfileInitial()) {
    on<SubmitGetProfileEvent>(_submit);
  }

  FutureOr<void> _submit(
    SubmitGetProfileEvent event,
    Emitter<IGetProfileState> emit,
  ) async {
    emit(GetProfileLoading());
    try {
      final usecase = locator<
        IUseCase<BaseModel<ProfileModel>?, Null>
      >(instanceName: 'GetProfile');
      final response = await usecase(null);
      response.fold(
        (failure) => emit(GetProfileFailed(failure.message)),
        (value) => emit(GetProfileLoaded(profileModel: value)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(GetProfileFailed(error.toString()));
    }
  }
}
