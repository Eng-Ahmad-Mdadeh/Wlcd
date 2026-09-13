import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';


part 'mark_all_notifications_read_event.dart';
part 'mark_all_notifications_read_state.dart';

class MarkAllNotificationsReadBloc extends Bloc<IMarkAllNotificationsReadEvent, IMarkAllNotificationsReadState> {
  MarkAllNotificationsReadBloc() : super(const MarkAllNotificationsReadInitial()) {
    on<MarkAllNotificationsReadEvent>(_execute);
  }

  FutureOr<void> _execute(
    MarkAllNotificationsReadEvent event,
    Emitter<IMarkAllNotificationsReadState> emit,
  ) async {
    emit(const MarkAllNotificationsReadLoading());
    final usecase = locator<IUseCase<BaseModel<Object>?, Null>>(
      instanceName: 'MarkAllNotificationsRead',
    );
    final response = await usecase(null);
    response.fold(
      (failure) => emit(MarkAllNotificationsReadFailed(failure.message)),
      (value) => emit(MarkAllNotificationsReadLoaded(value?.data)),
    );
  }
}
