import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/repository/notifications/i_notifications_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';
import 'package:wlcd/data/model/notifications/unread_notification_count/unread_notification_count_model.dart';

@Injectable(as: IUseCase<BaseModel<UnreadNotificationCountModel>?, Null>)
@Named('GetUnreadNotificationCount')
class GetUnreadNotificationCountUsecase implements IUseCase<BaseModel<UnreadNotificationCountModel>?, Null> {
  const GetUnreadNotificationCountUsecase(this._repository);
  final INotificationsRepository _repository;

  @override
  Future<Either<AppException, BaseModel<UnreadNotificationCountModel>?>> call(Null data) =>
      _repository.getUnreadNotificationCount();
}
