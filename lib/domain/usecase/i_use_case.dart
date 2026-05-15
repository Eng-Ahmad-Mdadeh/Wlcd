 import 'package:dartz/dartz.dart';

import '../../core/exceptions/app_exception.dart';

abstract interface class IUseCase<T, B> {
  Future<Either<AppException, T>> call(B b);
}
