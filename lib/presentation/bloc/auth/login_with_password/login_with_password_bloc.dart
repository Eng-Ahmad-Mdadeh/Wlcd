import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/auth/auth_model.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/entity/auth/login_with_password_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'login_with_password_event.dart';
part 'login_with_password_state.dart';

class LoginWithPasswordBloc extends Bloc<ILoginWithPasswordEvent, ILoginWithPasswordState> {
  LoginWithPasswordBloc() : super(LoginWithPasswordInitial()) {
    on<SubmitLoginWithPasswordEvent>(_submit);
  }

  FutureOr<void> _submit(SubmitLoginWithPasswordEvent event, Emitter<ILoginWithPasswordState> emit) async {
    emit(LoginWithPasswordLoading());
    try {
      final usecase = locator<
        IUseCase<BaseModel<AuthModel>?, LoginWithPasswordEntity>
      >(instanceName: 'LoginWithPassword');
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(LoginWithPasswordFailed(failure.message)),
        (value) => emit(LoginWithPasswordLoaded(authModel: value)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(LoginWithPasswordFailed(error.toString()));
    }
  }
}
