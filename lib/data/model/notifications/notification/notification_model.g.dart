// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'notification_model.dart';

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      notificationId: json['notificationId'] as String,
      notificationType: json['notificationType'] as String,
      category: json['category'] as String,
      readState: json['readState'] as String,
      deliveryState: json['deliveryState'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      deepLinkRef: json['deepLinkRef'] as String?,
      navigationTarget: json['navigationTarget'] == null ? null :
          NavigationTargetModel.fromJson(json['navigationTarget'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      version: (json['version'] as num).toInt(),
    );
