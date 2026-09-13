import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';
import 'package:wlcd/data/model/notifications/notification_preferences/notification_preferences_model.dart';
import 'package:wlcd/domain/entity/notifications/update_notification_preferences_entity.dart';

part 'update_notification_preferences_event.dart';
part 'update_notification_preferences_state.dart';

class UpdateNotificationPreferencesBloc extends Bloc<IUpdateNotificationPreferencesEvent, IUpdateNotificationPreferencesState> {
  UpdateNotificationPreferencesBloc() : super(const UpdateNotificationPreferencesInitial()) {
    on<UpdateNotificationPreferencesEvent>(_execute);
  }

  FutureOr<void> _execute(
    UpdateNotificationPreferencesEvent event,
    Emitter<IUpdateNotificationPreferencesState> emit,
  ) async {
    emit(const UpdateNotificationPreferencesLoading());
    final usecase = locator<IUseCase<BaseModel<NotificationPreferencesModel>?, UpdateNotificationPreferencesEntity>>(
      instanceName: 'UpdateNotificationPreferences',
    );
    final response = await usecase(event.entity);
    response.fold(
      (failure) => emit(UpdateNotificationPreferencesFailed(failure.message)),
      (value) => emit(UpdateNotificationPreferencesLoaded(value?.data)),
    );
  }
}
