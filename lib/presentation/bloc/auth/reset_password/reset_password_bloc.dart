import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/auth/operation_success_model.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/entity/auth/reset_password_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<IResetPasswordEvent, IResetPasswordState> {
  ResetPasswordBloc() : super(ResetPasswordInitial()) {
    on<SubmitResetPasswordEvent>(_submit);
  }

  FutureOr<void> _submit(SubmitResetPasswordEvent event, Emitter<IResetPasswordState> emit) async {
    emit(ResetPasswordLoading());
    try {
      final usecase = locator<
        IUseCase<BaseModel<OperationSuccessModel>?, ResetPasswordEntity>
      >(instanceName: 'ResetPassword');
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(ResetPasswordFailed(failure.message)),
        (value) => emit(ResetPasswordLoaded(result: value)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(ResetPasswordFailed(error.toString()));
    }
  }
}
