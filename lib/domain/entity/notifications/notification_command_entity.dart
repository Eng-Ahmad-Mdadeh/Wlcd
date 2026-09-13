import 'package:equatable/equatable.dart';

class NotificationCommandEntity extends Equatable {
  const NotificationCommandEntity({
    required this.notificationId,
  });

  final String notificationId;

  @override
  List<Object?> get props => [notificationId];
}
