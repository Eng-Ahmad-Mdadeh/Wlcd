part of 'get_notification_bloc.dart';

sealed class IGetNotificationState extends Equatable {
  const IGetNotificationState();
}

final class GetNotificationInitial extends IGetNotificationState {
  const GetNotificationInitial();
  @override
  List<Object?> get props => const [];
}

final class GetNotificationLoading extends IGetNotificationState {
  const GetNotificationLoading();
  @override
  List<Object?> get props => const [];
}

final class GetNotificationLoaded extends IGetNotificationState {
  const GetNotificationLoaded(this.notification);
  final NotificationModel? notification;
  @override
  List<Object?> get props => [notification];
}

final class GetNotificationFailed extends IGetNotificationState {
  const GetNotificationFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
