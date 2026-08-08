import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/auth/operation_success_model.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/entity/auth/request_password_reset_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'request_password_reset_event.dart';
part 'request_password_reset_state.dart';

class RequestPasswordResetBloc extends Bloc<IRequestPasswordResetEvent, IRequestPasswordResetState> {
  RequestPasswordResetBloc() : super(RequestPasswordResetInitial()) {
    on<SubmitRequestPasswordResetEvent>(_submit);
  }

  FutureOr<void> _submit(SubmitRequestPasswordResetEvent event, Emitter<IRequestPasswordResetState> emit) async {
    emit(RequestPasswordResetLoading());
    try {
      final usecase = locator<
        IUseCase<BaseModel<OperationSuccessModel>?, RequestPasswordResetEntity>
      >(instanceName: 'RequestPasswordReset');
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(RequestPasswordResetFailed(failure.message)),
        (value) => emit(RequestPasswordResetLoaded(result: value)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(RequestPasswordResetFailed(error.toString()));
    }
  }
}
