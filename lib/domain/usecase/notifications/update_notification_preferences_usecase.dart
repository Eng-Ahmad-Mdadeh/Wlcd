import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/repository/notifications/i_notifications_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';
import 'package:wlcd/data/model/notifications/notification_preferences/notification_preferences_model.dart';
import 'package:wlcd/domain/entity/notifications/update_notification_preferences_entity.dart';

@Injectable(as: IUseCase<BaseModel<NotificationPreferencesModel>?, UpdateNotificationPreferencesEntity>)
@Named('UpdateNotificationPreferences')
class UpdateNotificationPreferencesUsecase implements IUseCase<BaseModel<NotificationPreferencesModel>?, UpdateNotificationPreferencesEntity> {
  const UpdateNotificationPreferencesUsecase(this._repository);
  final INotificationsRepository _repository;

  @override
  Future<Either<AppException, BaseModel<NotificationPreferencesModel>?>> call(UpdateNotificationPreferencesEntity data) =>
      _repository.updateNotificationPreferences(data);
}
