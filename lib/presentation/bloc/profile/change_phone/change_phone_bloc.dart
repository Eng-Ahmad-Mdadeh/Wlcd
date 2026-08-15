import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/profile/phone_identifier_model.dart';
import 'package:wlcd/domain/entity/profile/change_phone_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'change_phone_event.dart';
part 'change_phone_state.dart';

class ChangePhoneBloc extends Bloc<IChangePhoneEvent, IChangePhoneState> {
  ChangePhoneBloc() : super(ChangePhoneInitial()) {
    on<SubmitChangePhoneEvent>(_submit);
  }

  FutureOr<void> _submit(
    SubmitChangePhoneEvent event,
    Emitter<IChangePhoneState> emit,
  ) async {
    emit(ChangePhoneLoading());
    try {
      final usecase = locator<
        IUseCase<BaseModel<PhoneIdentifierModel>?, ChangePhoneEntity>
      >(instanceName: 'ChangePhone');
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(ChangePhoneFailed(failure.message)),
        (value) => emit(ChangePhoneLoaded(result: value)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(ChangePhoneFailed(error.toString()));
    }
  }
}
