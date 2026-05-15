import 'dart:async';
import 'dart:developer';

import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/delete_account/delete_account_model.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'delete_account_event.dart';
part 'delete_account_state.dart';

class DeleteAccountBloc extends Bloc<IDeleteAccountEvent, IDeleteAccountState> {
  DeleteAccountBloc() : super(DeleteAccountInitial()) {
    on<DeleteAccountEvent>(_deleteAccount);
  }

  FutureOr<void> _deleteAccount(
    DeleteAccountEvent event,
    Emitter<IDeleteAccountState> emit,
  ) async {
    emit(DeleteAccountLoading());

    try {
      final result =
          await locator<IUseCase<BaseModel<DeleteAccountModel>?, Null>>(
        instanceName: 'DeleteAccount',
      )(null);

      result.fold(
        (l) => emit(DeleteAccountFailed(l.message)),
        (r) => emit(DeleteAccountLoaded(response: r)),
      );
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      emit(DeleteAccountFailed(e.toString()));
    }
  }
}
