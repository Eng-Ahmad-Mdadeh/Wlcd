import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/repository/notifications/i_notifications_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

@Injectable(as: IUseCase<BaseModel<Object>?, Null>)
@Named('MarkAllNotificationsRead')
class MarkAllNotificationsReadUsecase implements IUseCase<BaseModel<Object>?, Null> {
  const MarkAllNotificationsReadUsecase(this._repository);
  final INotificationsRepository _repository;

  @override
  Future<Either<AppException, BaseModel<Object>?>> call(Null data) =>
      _repository.markAllNotificationsRead();
}
