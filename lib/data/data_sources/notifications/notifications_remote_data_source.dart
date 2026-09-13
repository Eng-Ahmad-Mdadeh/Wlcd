import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/constants/api_endpoints.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/data_sources/base/base_remote_data_source.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/notifications/notification/notification_model.dart';
import 'package:wlcd/data/model/notifications/notification_preferences/notification_preferences_model.dart';
import 'package:wlcd/data/model/pagination/pagination_model.dart';
import 'package:wlcd/data/model/notifications/unread_notification_count/unread_notification_count_model.dart';
import 'package:wlcd/domain/entity/notifications/list_notifications_entity.dart';
import 'package:wlcd/domain/entity/notifications/notification_command_entity.dart';
import 'package:wlcd/domain/entity/notifications/update_notification_preferences_entity.dart';

@injectable
class NotificationsRemoteDataSource extends BaseRemoteDataSource<Object> {
  NotificationsRemoteDataSource() : super(ApiEndpoints.accounts);

  Future<Either<AppException, BaseModel<PaginationModel<NotificationModel>>?>> listNotifications(
    ListNotificationsEntity entity,
  ) => fetchDataAs<PaginationModel<NotificationModel>>(
    endpoint: ApiEndpoints.notifications,
    queryParams: entity.toQueryParameters(),
    fromJsonT: _notificationsFromJson,
    wrappedResponse: false,
  );

  Future<Either<AppException, BaseModel<UnreadNotificationCountModel>?>>
  getUnreadNotificationCount() => fetchDataAs<UnreadNotificationCountModel>(
    endpoint: '${ApiEndpoints.notifications}${ApiEndpoints.unreadNotificationCount}',
    fromJsonT: _unreadCountFromJson,
    wrappedResponse: false,
  );

  Future<Either<AppException, BaseModel<Object>?>> markAllNotificationsRead() =>
      postDataAs<Object>(
    endpoint: '${ApiEndpoints.notifications}${ApiEndpoints.markAllNotificationsRead}',
    isFormDate: false,
  );

  Future<Either<AppException, BaseModel<NotificationModel>?>> getNotification(
    NotificationCommandEntity entity,
  ) => fetchDataAs<NotificationModel>(
    endpoint: '${ApiEndpoints.notifications}/${entity.notificationId}',
    fromJsonT: _notificationFromJson,
    wrappedResponse: false,
  );

  Future<Either<AppException, BaseModel<NotificationModel>?>> markNotificationRead(
    NotificationCommandEntity entity,
  ) => postDataAs<NotificationModel>(
    endpoint: '${ApiEndpoints.notifications}/${entity.notificationId}/read',
    isFormDate: false,
    fromJsonT: _notificationFromJson,
    wrappedResponse: false,
  );

  Future<Either<AppException, BaseModel<NotificationPreferencesModel>?>>
  getNotificationPreferences() => fetchDataAs<NotificationPreferencesModel>(
    endpoint: ApiEndpoints.notificationPreferences,
    fromJsonT: _preferencesFromJson,
    wrappedResponse: false,
  );

  Future<Either<AppException, BaseModel<NotificationPreferencesModel>?>>
  updateNotificationPreferences(UpdateNotificationPreferencesEntity entity) =>
      putDataAs<NotificationPreferencesModel>(
        endpoint: ApiEndpoints.notificationPreferences,
        data: entity.toJson(),
        isFormDate: false,
        headers: {
          if (entity.ifMatch != null) 'If-Match': entity.ifMatch!,
        },
        fromJsonT: _preferencesFromJson,
        wrappedResponse: false,
      );

  static PaginationModel<NotificationModel> _notificationsFromJson(Object? json) =>
      PaginationModel<NotificationModel>.fromJson(
        json as Map<String, dynamic>,
        (item) => NotificationModel.fromJson(item as Map<String, dynamic>),
      );
  static NotificationModel _notificationFromJson(Object? json) =>
      NotificationModel.fromJson(json as Map<String, dynamic>);
  static NotificationPreferencesModel _preferencesFromJson(Object? json) =>
      NotificationPreferencesModel.fromJson(json as Map<String, dynamic>);
  static UnreadNotificationCountModel _unreadCountFromJson(Object? json) =>
      UnreadNotificationCountModel.fromJson(json as Map<String, dynamic>);
}
