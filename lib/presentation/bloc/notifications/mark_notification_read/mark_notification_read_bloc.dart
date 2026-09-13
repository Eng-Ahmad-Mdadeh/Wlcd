import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';
import 'package:wlcd/data/model/notifications/notification/notification_model.dart';
import 'package:wlcd/domain/entity/notifications/notification_command_entity.dart';

part 'mark_notification_read_event.dart';
part 'mark_notification_read_state.dart';

class MarkNotificationReadBloc extends Bloc<IMarkNotificationReadEvent, IMarkNotificationReadState> {
  MarkNotificationReadBloc() : super(const MarkNotificationReadInitial()) {
    on<MarkNotificationReadEvent>(_execute);
  }

  FutureOr<void> _execute(
    MarkNotificationReadEvent event,
    Emitter<IMarkNotificationReadState> emit,
  ) async {
    emit(const MarkNotificationReadLoading());
    final usecase = locator<IUseCase<BaseModel<NotificationModel>?, NotificationCommandEntity>>(
      instanceName: 'MarkNotificationRead',
    );
    final response = await usecase(event.entity);
    response.fold(
      (failure) => emit(MarkNotificationReadFailed(failure.message)),
      (value) => emit(MarkNotificationReadLoaded(value?.data)),
    );
  }
}
