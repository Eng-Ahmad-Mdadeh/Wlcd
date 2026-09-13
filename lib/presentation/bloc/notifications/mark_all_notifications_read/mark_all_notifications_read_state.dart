part of 'mark_all_notifications_read_bloc.dart';

sealed class IMarkAllNotificationsReadState extends Equatable {
  const IMarkAllNotificationsReadState();
}

final class MarkAllNotificationsReadInitial extends IMarkAllNotificationsReadState {
  const MarkAllNotificationsReadInitial();
  @override
  List<Object?> get props => const [];
}

final class MarkAllNotificationsReadLoading extends IMarkAllNotificationsReadState {
  const MarkAllNotificationsReadLoading();
  @override
  List<Object?> get props => const [];
}

final class MarkAllNotificationsReadLoaded extends IMarkAllNotificationsReadState {
  const MarkAllNotificationsReadLoaded(this.result);
  final Object? result;
  @override
  List<Object?> get props => [result];
}

final class MarkAllNotificationsReadFailed extends IMarkAllNotificationsReadState {
  const MarkAllNotificationsReadFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
