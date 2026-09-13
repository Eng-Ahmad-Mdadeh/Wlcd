import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';
import 'package:wlcd/data/model/notifications/notification/notification_model.dart';
import 'package:wlcd/domain/entity/notifications/notification_command_entity.dart';

part 'get_notification_event.dart';
part 'get_notification_state.dart';

class GetNotificationBloc extends Bloc<IGetNotificationEvent, IGetNotificationState> {
  GetNotificationBloc() : super(const GetNotificationInitial()) {
    on<LoadNotificationEvent>(_execute);
  }

  FutureOr<void> _execute(
    LoadNotificationEvent event,
    Emitter<IGetNotificationState> emit,
  ) async {
    emit(const GetNotificationLoading());
    final usecase = locator<IUseCase<BaseModel<NotificationModel>?, NotificationCommandEntity>>(
      instanceName: 'GetNotification',
    );
    final response = await usecase(event.entity);
    response.fold(
      (failure) => emit(GetNotificationFailed(failure.message)),
      (value) => emit(GetNotificationLoaded(value?.data)),
    );
  }
}
