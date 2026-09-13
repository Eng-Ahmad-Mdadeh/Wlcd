import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/data_sources/notifications/notifications_remote_data_source.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/notifications/notification/notification_model.dart';
import 'package:wlcd/data/model/notifications/notification_preferences/notification_preferences_model.dart';
import 'package:wlcd/data/model/pagination/pagination_model.dart';
import 'package:wlcd/data/model/notifications/unread_notification_count/unread_notification_count_model.dart';
import 'package:wlcd/domain/entity/notifications/list_notifications_entity.dart';
import 'package:wlcd/domain/entity/notifications/notification_command_entity.dart';
import 'package:wlcd/domain/entity/notifications/update_notification_preferences_entity.dart';
import 'package:wlcd/domain/repository/notifications/i_notifications_repository.dart';

@Injectable(as: INotificationsRepository)
class NotificationsRepository implements INotificationsRepository {
  const NotificationsRepository(this._remoteDataSource);
  final NotificationsRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppException, BaseModel<PaginationModel<NotificationModel>>?>> listNotifications(ListNotificationsEntity entity) => _remoteDataSource.listNotifications(entity);
  @override
  Future<Either<AppException, BaseModel<UnreadNotificationCountModel>?>> getUnreadNotificationCount() => _remoteDataSource.getUnreadNotificationCount();
  @override
  Future<Either<AppException, BaseModel<Object>?>> markAllNotificationsRead() => _remoteDataSource.markAllNotificationsRead();
  @override
  Future<Either<AppException, BaseModel<NotificationModel>?>> getNotification(NotificationCommandEntity entity) => _remoteDataSource.getNotification(entity);
  @override
  Future<Either<AppException, BaseModel<NotificationModel>?>> markNotificationRead(NotificationCommandEntity entity) => _remoteDataSource.markNotificationRead(entity);
  @override
  Future<Either<AppException, BaseModel<NotificationPreferencesModel>?>> getNotificationPreferences() => _remoteDataSource.getNotificationPreferences();
  @override
  Future<Either<AppException, BaseModel<NotificationPreferencesModel>?>> updateNotificationPreferences(UpdateNotificationPreferencesEntity entity) => _remoteDataSource.updateNotificationPreferences(entity);
}
