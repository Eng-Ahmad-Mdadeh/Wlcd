import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/constants/app_storage_paths.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';

@Injectable()
class AuthStorageDataSource {
  const AuthStorageDataSource(this._storage);

  final FlutterSecureStorage _storage;

  Future<Either<AppException, void>> logout() async {
    try {
      await _storage.delete(key: AppStoragePaths.token);
      await _storage.delete(key: AppStoragePaths.sessionId);
      await _storage.delete(key: AppStoragePaths.profileComplete);
      await _storage.delete(key: AppStoragePaths.onboardingComplete);
      return const Right(null);
    } catch (e) {
      return Left(UnKnownException(e.toString()));
    }
  }

  Future<Either<AppException, void>> storeToken(String? token) async {
    try {
      if ((token ?? '').isEmpty) return const Right(null);
      await _storage.write(key: AppStoragePaths.token, value: token);
      return const Right(null);
    } catch (e) {
      return Left(UnKnownException(e.toString()));
    }
  }

  Future<Either<AppException, String?>> getToken() async {
    try {
      return Right(await _storage.read(key: AppStoragePaths.token));
    } catch (e) {
      return Left(UnKnownException(e.toString()));
    }
  }

  Future<Either<AppException, void>> storeSessionId(String? sessionId) async {
    try {
      if ((sessionId ?? '').isEmpty) return const Right(null);
      await _storage.write(key: AppStoragePaths.sessionId, value: sessionId);
      return const Right(null);
    } catch (e) {
      return Left(UnKnownException(e.toString()));
    }
  }
}
