part of 'mark_notification_read_bloc.dart';

sealed class IMarkNotificationReadState extends Equatable {
  const IMarkNotificationReadState();
}

final class MarkNotificationReadInitial extends IMarkNotificationReadState {
  const MarkNotificationReadInitial();
  @override
  List<Object?> get props => const [];
}

final class MarkNotificationReadLoading extends IMarkNotificationReadState {
  const MarkNotificationReadLoading();
  @override
  List<Object?> get props => const [];
}

final class MarkNotificationReadLoaded extends IMarkNotificationReadState {
  const MarkNotificationReadLoaded(this.notification);
  final NotificationModel? notification;
  @override
  List<Object?> get props => [notification];
}

final class MarkNotificationReadFailed extends IMarkNotificationReadState {
  const MarkNotificationReadFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
