import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';
import 'package:wlcd/data/model/pagination/pagination_model.dart';
import 'package:wlcd/data/model/notifications/notification/notification_model.dart';
import 'package:wlcd/domain/entity/notifications/list_notifications_entity.dart';

part 'list_notifications_event.dart';
part 'list_notifications_state.dart';

class ListNotificationsBloc extends Bloc<IListNotificationsEvent, IListNotificationsState> {
  ListNotificationsBloc() : super(const ListNotificationsInitial()) {
    on<LoadNotificationsEvent>(_execute);
  }

  FutureOr<void> _execute(
    LoadNotificationsEvent event,
    Emitter<IListNotificationsState> emit,
  ) async {
    emit(const ListNotificationsLoading());
    final usecase = locator<IUseCase<BaseModel<PaginationModel<NotificationModel>>?, ListNotificationsEntity>>(
      instanceName: 'ListNotifications',
    );
    final response = await usecase(event.entity);
    response.fold(
      (failure) => emit(ListNotificationsFailed(failure.message)),
      (value) => emit(ListNotificationsLoaded(value?.data)),
    );
  }
}
