import 'dart:async';
import 'dart:developer';

import 'package:wlcd/domain/usecase/i_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';

part 'logout_event.dart';

part 'logout_state.dart';

class LogoutBloc extends Bloc<ILogoutEvent, ILogoutState> {
  LogoutBloc() : super(LogoutInitial()) {
    on<LogoutEvent>(_logout);
  }

  FutureOr<void> _logout(event, emit) async {
    emit(LogoutLoading());
    try {
      final result = await locator<IUseCase<void, Null>>(instanceName: 'LogOut')(null);
      result.fold(
        (l) => emit(LogoutFailed(l.message)),
        (r) => emit(const LogoutLoaded()),
      );
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      emit(LogoutFailed(e.toString()));
    }
  }
}
