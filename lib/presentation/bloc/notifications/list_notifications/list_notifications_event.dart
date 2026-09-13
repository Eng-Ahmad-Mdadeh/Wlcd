part of 'list_notifications_bloc.dart';

sealed class IListNotificationsEvent extends Equatable {
  const IListNotificationsEvent();
}

final class LoadNotificationsEvent extends IListNotificationsEvent {
  const LoadNotificationsEvent(this.entity);

  final ListNotificationsEntity entity;

  @override
  List<Object?> get props => [entity];
}
