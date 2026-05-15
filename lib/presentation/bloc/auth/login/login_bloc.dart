import 'dart:async';
import 'dart:developer';

import 'package:wlcd/domain/entity/auth/auth_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/auth/auth_model.dart';
import 'package:wlcd/data/model/base/base_model.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<ILoginEvent, ILoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>(_login);
  }

  FutureOr<void> _login(event, emit) async {
    emit(LoginLoading());
    try {
      final result = await locator<IUseCase<BaseModel<AuthModel>?, AuthEntity>>(instanceName: 'Login')(event.entity);
      result.fold(
        (l) => emit(LoginFailed(l.message)),
        (r) => emit(LoginLoaded(authModel: r)),
      );
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      emit(LoginFailed(e.toString()));
    }
  }
}
