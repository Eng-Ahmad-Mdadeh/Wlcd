import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/pagination/pagination_model.dart';

import '../../../core/exceptions/app_exception.dart';
import '../../../core/helper/local_storage_helper.dart';
import '../../../core/services/locator/locator.dart';

class BaseLocalDataSource<T> {
  final LocalStorageHelper _localHelper = locator<LocalStorageHelper>();
  final String baseBox;

  BaseLocalDataSource(this.baseBox);

  Future<Either<AppException, PaginationModel<T>?>> fetchAll(T Function(Object? json) fromJsonT, [num? page]) async {
    try {
      final response = await _localHelper.getAll(baseBox);
      return response.fold(
        (error) => Left(error),
        (right) {
          return Right(BaseModel<PaginationModel<T>>.fromJson(
            right.date!,
            (json) => PaginationModel<T>.fromJson(json as Map<String, dynamic>, fromJsonT),
          ).data);
        },
      );
    } on AppException catch (e, s) {
      log(e.message);
      log(s.toString());
      return Left(e);
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      return Left(UnKnownException(e.toString()));
    }
  }

  Future<Either<AppException, T?>> fetchData({
    String key = '',
    required T Function(Object? json) fromJsonT,
  }) async {
    try {
      final response = await _localHelper.getValue(baseBox, key);
      return response.fold(
        (e) => Left(e),
        (r) {
          if (r?.date == null) return const Right(null);
          return Right(BaseModel<T>.fromJson(r.date, fromJsonT).data);
        },
      );
    } on AppException catch (e, s) {
      log(e.message);
      log(s.toString());
      return Left(e);
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      return Left(UnKnownException(e.toString()));
    }
  }

  Future<Either<AppException, T?>> saveData({
    String key = '',
    Map<String, dynamic>? data,
    List<Map<String, dynamic>>? files,
    required T Function(Object? json) fromJsonT,
  }) async {
    try {
      final response = await _localHelper.saveValue(baseBox, key, data);
      return response.fold(
        (e) => Left(e),
        (r) => Right(BaseModel<T>.fromJson(r, fromJsonT).data),
      );
    } on AppException catch (e, s) {
      log(e.message);
      log(s.toString());
      return Left(e);
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      return Left(UnKnownException(e.toString()));
    }
  }

  Future<Either<AppException, bool>> deleteData({
    String key = '',
    Map<String, dynamic>? data,
    required T Function(Object? json) fromJsonT,
  }) async {
    try {
      final response = await _localHelper.deleteValue(baseBox, key);
      return response.fold(
        (e) => Left(e),
        (r) => Right(r),
      );
    } on AppException catch (e, s) {
      log(e.message);
      log(s.toString());
      return Left(e);
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      return Left(UnKnownException(e.toString()));
    }
  }
}
