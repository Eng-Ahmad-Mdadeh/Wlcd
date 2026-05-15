import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/pagination/pagination_model.dart';

import '../../../core/exceptions/app_exception.dart';
import '../../../core/helper/network_helper.dart';
import '../../../core/services/locator/locator.dart';

class BaseRemoteDataSource<T> {
  final NetworkHelper _networkHelper = locator<NetworkHelper>();
  final String baseEndpoint;

  BaseRemoteDataSource(this.baseEndpoint);

  Future<Either<AppException, PaginationModel<T>?>> fetchAll(T Function(Object? json) fromJsonT, [num? page]) async {
    try {
      final response = await _networkHelper.get('$baseEndpoint${page != null ? '?per_page=$page' : ''}');
      return response.fold(
        (error) => Left(error),
        (right) {
          return Right(BaseModel<PaginationModel<T>>.fromJson(
            right.data!,
            (json) => PaginationModel<T>.fromJson(json as Map<String, dynamic>, fromJsonT),
          ).data);
        },
      );
    } on AppException catch (e, s) {
      log("############################# FETCH APP EXCEPTION ################################");
      log(e.message);
      log(s.toString());
      log("#################################################################################");
      return Left(e);
    } catch (e, s) {
      log("############################# FETCH EXCEPTION ####################################");
      log(e.toString());
      log(s.toString());
      log("#################################################################################");
      return Left(UnKnownException(e.toString()));
    }
  }

  Future<Either<AppException, BaseModel<PaginationModel<T>>?>> fetchPagination({
    String endpoint = '',
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
    required T Function(Object? json) fromJsonT,
  }) async {
    try {
      final response = await _networkHelper.get(
        baseEndpoint + endpoint,
        queryParams: queryParams,
        data: data,
      );
      return response.fold(
        (error) => Left(error),
        (right) {
          return Right(BaseModel<PaginationModel<T>>.fromJson(
              right.data!, (json) => PaginationModel<T>.fromJson(json as Map<String, dynamic>, fromJsonT)));
        },
      );
    } on AppException catch (e, s) {
      log("######################## FETCH PAGINATION APP EXCEPTION #########################");
      log(e.toString());
      log(s.toString());
      log("#################################################################################");
      return Left(e);
    } catch (e, s) {
      log("####################### FETCH PAGINATION EXCEPTION ##############################");
      log(e.toString());
      log(s.toString());
      log("#################################################################################");
      return Left(AppException('Unknown error'));
    }
  }

  Future<Either<AppException, BaseModel<T>?>> fetchData({
    String endpoint = '',
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
    required T Function(Object? json) fromJsonT,
  }) async {
    try {
      final response = await _networkHelper.get(
        baseEndpoint + endpoint,
        queryParams: queryParams,
        data: data,
      );
      return response.fold(
        (e) => Left(e),
        (r) => Right(BaseModel<T>.fromJson(r.data!, fromJsonT)),
      );
    } on AppException catch (e, s) {
      log("############################# FETCH APP EXCEPTION ################################");
      log(e.message);
      log(s.toString());
      log("#################################################################################");
      return Left(e);
    } catch (e, s) {
      log("############################# FETCH EXCEPTION ####################################");
      log(e.toString());
      log(s.toString());
      log("#################################################################################");
      return Left(UnKnownException(e.toString()));
    }
  }
  


  Future<Either<AppException, BaseModel<T>?>> postData({
    String endpoint = '',
    Map<String, dynamic>? data,
    bool isFormDate = true,
    List<Map<String, dynamic>>? files,
    T Function(Object? json)? fromJsonT,
  }) async {
    try {
      final response = await _networkHelper.post(baseEndpoint + endpoint, data: data, files: files, isFormDate: isFormDate);
      return response.fold(
        (e) => Left(e),
        (r) {
          if (fromJsonT == null) return const Right(null);
          return Right(BaseModel<T>.fromJson(r.data!, fromJsonT));
        },
      );
    } on AppException catch (e, s) {
      log("############################# POST APP EXCEPTION ################################");
      log(e.message);
      log(s.toString());
      log("#################################################################################");
      return Left(e);
    } catch (e, s) {
      log("############################# POST EXCEPTION ####################################");
      log(e.toString());
      log(s.toString());
      log("#################################################################################");
      return Left(UnKnownException(e.toString()));
    }
  }

  Future<Either<AppException, BaseModel<T>?>> patchData({
    String endpoint = '',
    Map<String, dynamic>? data,
    bool isFormData = true,
    List<Map<String, dynamic>>? files,
    T Function(Object? json)? fromJsonT,
  }) async {
    try {
      final response = await _networkHelper.patch(
        baseEndpoint + endpoint,
        data: data,
        isFormData: isFormData,
        files: files,
      );
      return response.fold(
        (e) => Left(e),
        (r) {
          if (fromJsonT == null) return const Right(null);
          return Right(BaseModel<T>.fromJson(r.data!, fromJsonT));
        },
      );
    } on AppException catch (e, s) {
      log("############################# PATCH APP EXCEPTION ################################");
      log(e.message);
      log(s.toString());
      log("#################################################################################");
      return Left(e);
    } catch (e, s) {
      log("############################# PATCH EXCEPTION ####################################");
      log(e.toString());
      log(s.toString());
      log("#################################################################################");
      return Left(UnKnownException(e.toString()));
    }
  }

  Future<Either<AppException, BaseModel<PaginationModel<T>>?>> patchPagination({
    String endpoint = '',
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
    bool isFormData = true,
    List<Map<String, dynamic>>? files,
    required T Function(Object? json) fromJsonT,
  }) async {
    try {
      final response = await _networkHelper.patchPagination(
      url:   baseEndpoint + endpoint,
        queryParams: queryParams,
        data: data,
        isFormData: isFormData,
        files: files,
        fromJsonT: fromJsonT,
      );
      return response.fold(
            (error) => Left(error),
            (right) => Right(right),
      );
    } on AppException catch (e, s) {
      log("############################# PATCH PAGINATION APP EXCEPTION #############################");
      log(e.message);
      log(s.toString());
      log("#########################################################################################");
      return Left(e);
    } catch (e, s) {
      log("############################# PATCH PAGINATION EXCEPTION #################################");
      log(e.toString());
      log(s.toString());
      log("#########################################################################################");
      return Left(UnKnownException(e.toString()));
    }
  }
  Future<Either<AppException, BaseModel<T>?>> deleteData({
    String endpoint = '',
    Map<String, dynamic>? data,
    T Function(Object? json)? fromJsonT,
  }) async {
    try {
      final response = await _networkHelper.delete('$baseEndpoint$endpoint', data: data);
      return response.fold(
        (e) => Left(e),
        (r) {
          if (fromJsonT == null) return const Right(null);
          return Right(BaseModel<T>.fromJson(r.data!, fromJsonT));
        },
      );
    } on AppException catch (e, s) {
      log("############################# DELETE APP EXCEPTION ####################################");
      log(e.toString());
      log(s.toString());
      log("####################################################################################");
      return Left(e);
    } catch (e, s) {
      log("############################# DELETE EXCEPTION ####################################");
      log(e.toString());
      log(s.toString());
      log("####################################################################################");
      return Left(UnKnownException(e.toString()));
    }
  }

  Future<Either<AppException, BaseModel<PaginationModel<T>>?>> deletePagination({
    String endpoint = '',
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
    bool isFormData = false,
    required T Function(Object? json) fromJsonT,
  }) async {
    try {
      final response = await _networkHelper.deletePagination(
      url:   baseEndpoint + endpoint,
        queryParams: queryParams,
        data: data,
        isFormData: isFormData,
        fromJsonT: fromJsonT,
      );
      return response.fold(
            (error) => Left(error),
            (right) => Right(right),
      );
    } on AppException catch (e, s) {
      log("############################# DELETE PAGINATION APP EXCEPTION ###########################");
      log(e.toString());
      log(s.toString());
      log("#########################################################################################");
      return Left(e);
    } catch (e, s) {
      log("############################# DELETE PAGINATION EXCEPTION ################################");
      log(e.toString());
      log(s.toString());
      log("#########################################################################################");
      return Left(UnKnownException(e.toString()));
    }
  }

   Future<Either<AppException, BaseModel<T>?>> putData({
    String endpoint = '',
    Map<String, dynamic>? data,
    bool isFormDate = true,
    List<Map<String, dynamic>>? files,
    T Function(Object? json)? fromJsonT,
  }) async {
    try {
      final response = await _networkHelper.put(baseEndpoint + endpoint, data: data, files: files, isFormDate: isFormDate);
      return response.fold(
        (e) => Left(e),
        (r) {
          if (fromJsonT == null) return const Right(null);
          return Right(BaseModel<T>.fromJson(r.data!, fromJsonT));
        },
      );
    } on AppException catch (e, s) {
      log("############################# PUT APP EXCEPTION ################################");
      log(e.message);
      log(s.toString());
      log("#################################################################################");
      return Left(e);
    } catch (e, s) {
      log("############################# PUT EXCEPTION ####################################");
      log(e.toString());
      log(s.toString());
      log("#################################################################################");
      return Left(UnKnownException(e.toString()));
    }
  }
}
