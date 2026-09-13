import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/repository/notifications/i_notifications_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';
import 'package:wlcd/data/model/pagination/pagination_model.dart';
import 'package:wlcd/data/model/notifications/notification/notification_model.dart';
import 'package:wlcd/domain/entity/notifications/list_notifications_entity.dart';

@Injectable(as: IUseCase<BaseModel<PaginationModel<NotificationModel>>?, ListNotificationsEntity>)
@Named('ListNotifications')
class ListNotificationsUsecase implements IUseCase<BaseModel<PaginationModel<NotificationModel>>?, ListNotificationsEntity> {
  const ListNotificationsUsecase(this._repository);
  final INotificationsRepository _repository;

  @override
  Future<Either<AppException, BaseModel<PaginationModel<NotificationModel>>?>> call(ListNotificationsEntity data) =>
      _repository.listNotifications(data);
}
