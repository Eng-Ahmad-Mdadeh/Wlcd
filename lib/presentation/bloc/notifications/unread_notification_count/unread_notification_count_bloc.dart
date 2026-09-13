import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';
import 'package:wlcd/data/model/notifications/unread_notification_count/unread_notification_count_model.dart';

part 'unread_notification_count_event.dart';
part 'unread_notification_count_state.dart';

class UnreadNotificationCountBloc extends Bloc<IUnreadNotificationCountEvent, IUnreadNotificationCountState> {
  UnreadNotificationCountBloc() : super(const UnreadNotificationCountInitial()) {
    on<LoadUnreadNotificationCountEvent>(_execute);
  }

  FutureOr<void> _execute(
    LoadUnreadNotificationCountEvent event,
    Emitter<IUnreadNotificationCountState> emit,
  ) async {
    emit(const UnreadNotificationCountLoading());
    final usecase = locator<IUseCase<BaseModel<UnreadNotificationCountModel>?, Null>>(
      instanceName: 'GetUnreadNotificationCount',
    );
    final response = await usecase(null);
    response.fold(
      (failure) => emit(UnreadNotificationCountFailed(failure.message)),
      (value) => emit(UnreadNotificationCountLoaded(value?.data)),
    );
  }
}
