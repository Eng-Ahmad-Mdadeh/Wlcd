import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';
import 'package:wlcd/data/model/notifications/notification_preferences/notification_preferences_model.dart';

part 'get_notification_preferences_event.dart';
part 'get_notification_preferences_state.dart';

class GetNotificationPreferencesBloc extends Bloc<IGetNotificationPreferencesEvent, IGetNotificationPreferencesState> {
  GetNotificationPreferencesBloc() : super(const GetNotificationPreferencesInitial()) {
    on<LoadNotificationPreferencesEvent>(_execute);
  }

  FutureOr<void> _execute(
    LoadNotificationPreferencesEvent event,
    Emitter<IGetNotificationPreferencesState> emit,
  ) async {
    emit(const GetNotificationPreferencesLoading());
    final usecase = locator<IUseCase<BaseModel<NotificationPreferencesModel>?, Null>>(
      instanceName: 'GetNotificationPreferences',
    );
    final response = await usecase(null);
    response.fold(
      (failure) => emit(GetNotificationPreferencesFailed(failure.message)),
      (value) => emit(GetNotificationPreferencesLoaded(value?.data)),
    );
  }
}
