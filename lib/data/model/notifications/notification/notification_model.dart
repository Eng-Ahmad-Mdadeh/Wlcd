import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wlcd/data/model/notifications/navigation_target/navigation_target_model.dart';

part 'notification_model.g.dart';

@JsonSerializable(createToJson: false)
class NotificationModel extends Equatable {
  const NotificationModel({
    required this.notificationId,
    required this.notificationType,
    required this.category,
    required this.readState,
    required this.deliveryState,
    required this.title,
    required this.body,
    this.deepLinkRef,
    this.navigationTarget,
    required this.createdAt,
    required this.version,
  });

  final String notificationId;
  final String notificationType;
  final String category;
  final String readState;
  final String deliveryState;
  final String title;
  final String body;
  final String? deepLinkRef;
  final NavigationTargetModel? navigationTarget;
  final DateTime createdAt;
  final int version;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  @override
  List<Object?> get props => [notificationId, notificationType, category, readState,
    deliveryState, title, body, deepLinkRef, navigationTarget, createdAt, version];
}
