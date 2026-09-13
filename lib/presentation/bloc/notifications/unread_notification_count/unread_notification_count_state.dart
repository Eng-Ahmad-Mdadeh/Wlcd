part of 'unread_notification_count_bloc.dart';

sealed class IUnreadNotificationCountState extends Equatable {
  const IUnreadNotificationCountState();
}

final class UnreadNotificationCountInitial extends IUnreadNotificationCountState {
  const UnreadNotificationCountInitial();
  @override
  List<Object?> get props => const [];
}

final class UnreadNotificationCountLoading extends IUnreadNotificationCountState {
  const UnreadNotificationCountLoading();
  @override
  List<Object?> get props => const [];
}

final class UnreadNotificationCountLoaded extends IUnreadNotificationCountState {
  const UnreadNotificationCountLoaded(this.count);
  final UnreadNotificationCountModel? count;
  @override
  List<Object?> get props => [count];
}

final class UnreadNotificationCountFailed extends IUnreadNotificationCountState {
  const UnreadNotificationCountFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
