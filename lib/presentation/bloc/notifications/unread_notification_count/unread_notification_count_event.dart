part of 'unread_notification_count_bloc.dart';

sealed class IUnreadNotificationCountEvent extends Equatable {
  const IUnreadNotificationCountEvent();
}

final class LoadUnreadNotificationCountEvent extends IUnreadNotificationCountEvent {
  const LoadUnreadNotificationCountEvent();


  @override
  List<Object?> get props => const [];
}
