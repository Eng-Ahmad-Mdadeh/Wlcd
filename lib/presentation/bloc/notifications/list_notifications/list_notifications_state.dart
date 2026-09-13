part of 'list_notifications_bloc.dart';

sealed class IListNotificationsState extends Equatable {
  const IListNotificationsState();
}

final class ListNotificationsInitial extends IListNotificationsState {
  const ListNotificationsInitial();
  @override
  List<Object?> get props => const [];
}

final class ListNotificationsLoading extends IListNotificationsState {
  const ListNotificationsLoading();
  @override
  List<Object?> get props => const [];
}

final class ListNotificationsLoaded extends IListNotificationsState {
  const ListNotificationsLoaded(this.notifications);
  final PaginationModel<NotificationModel>? notifications;
  @override
  List<Object?> get props => [notifications];
}

final class ListNotificationsFailed extends IListNotificationsState {
  const ListNotificationsFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
