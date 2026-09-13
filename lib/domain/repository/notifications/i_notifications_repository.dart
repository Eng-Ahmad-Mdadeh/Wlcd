import 'package:dartz/dartz.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/notifications/notification/notification_model.dart';
import 'package:wlcd/data/model/notifications/notification_preferences/notification_preferences_model.dart';
import 'package:wlcd/data/model/pagination/pagination_model.dart';
import 'package:wlcd/data/model/notifications/unread_notification_count/unread_notification_count_model.dart';
import 'package:wlcd/domain/entity/notifications/list_notifications_entity.dart';
import 'package:wlcd/domain/entity/notifications/notification_command_entity.dart';
import 'package:wlcd/domain/entity/notifications/update_notification_preferences_entity.dart';

abstract interface class INotificationsRepository {
  Future<Either<AppException, BaseModel<PaginationModel<NotificationModel>>?>> listNotifications(ListNotificationsEntity entity);
  Future<Either<AppException, BaseModel<UnreadNotificationCountModel>?>> getUnreadNotificationCount();
  Future<Either<AppException, BaseModel<Object>?>> markAllNotificationsRead();
  Future<Either<AppException, BaseModel<NotificationModel>?>> getNotification(NotificationCommandEntity entity);
  Future<Either<AppException, BaseModel<NotificationModel>?>> markNotificationRead(NotificationCommandEntity entity);
  Future<Either<AppException, BaseModel<NotificationPreferencesModel>?>> getNotificationPreferences();
  Future<Either<AppException, BaseModel<NotificationPreferencesModel>?>> updateNotificationPreferences(UpdateNotificationPreferencesEntity entity);
}
