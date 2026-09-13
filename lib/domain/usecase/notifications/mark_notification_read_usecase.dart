import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/repository/notifications/i_notifications_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';
import 'package:wlcd/data/model/notifications/notification/notification_model.dart';
import 'package:wlcd/domain/entity/notifications/notification_command_entity.dart';

@Injectable(as: IUseCase<BaseModel<NotificationModel>?, NotificationCommandEntity>)
@Named('MarkNotificationRead')
class MarkNotificationReadUsecase implements IUseCase<BaseModel<NotificationModel>?, NotificationCommandEntity> {
  const MarkNotificationReadUsecase(this._repository);
  final INotificationsRepository _repository;

  @override
  Future<Either<AppException, BaseModel<NotificationModel>?>> call(NotificationCommandEntity data) =>
      _repository.markNotificationRead(data);
}
