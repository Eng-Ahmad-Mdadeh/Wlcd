import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

import '../exceptions/app_exception.dart';
import '../exceptions/local_exception.dart';



@Injectable()
class   LocalStorageHelper {
  // فتح صندوق تخزين معين
  Future<Either<AppException, Box>> openBox(String boxName) async {
    try {
      final box = await Hive.openBox(boxName);
      return Right(box);
    } catch (e) {
      return Left(BoxOpenException('Failed to open box: $boxName'));
    }
  }

  // حفظ قيمة في صندوق معين
  Future<Either<AppException, dynamic>> saveValue(String boxName, String key, dynamic value) async {
    final boxOrError = await openBox(boxName);
    return boxOrError.fold(
          (error) => Left(error),
          (box) async {
        try {
          await box.put(key, value);
          final v = box.get(key);
          return Right(v);
        } catch (e) {
          return Left(StoreValueException('Failed to save value to box: $boxName'));
        }
      },
    );
  }

  // جلب قيمة من صندوق معين
  Future<Either<AppException, dynamic>> getAll(String boxName) async {
    final boxOrError = await openBox(boxName);
    return boxOrError.fold(
          (error) => Left(error),
          (box) {
        try {
          final value = box.values.toList();
          return Right(value);
        } catch (e) {
          return Left(GetValueException('Failed to retrieve value from box: $boxName'));
        }
      },
    );
  }

  // جلب قيمة من صندوق معين
  Future<Either<AppException, dynamic>> getValue(String boxName, String key) async {
    final boxOrError = await openBox(boxName);
    return boxOrError.fold(
          (error) => Left(error),
          (box) {
        try {
          final value = box.get(key);
          return Right(value);
        } catch (e) {
          return Left(GetValueException('Failed to retrieve value from box: $boxName'));
        }
      },
    );
  }

  // حذف قيمة من صندوق معين
  Future<Either<AppException, bool>> deleteValue(String boxName, String key) async {
    final boxOrError = await openBox(boxName);
    return boxOrError.fold(
          (error) => Left(error),
          (box) async {
        try {
          await box.delete(key);
          return const Right(true);
        } catch (e) {
          return Left(DeleteValueException('Failed to delete value from box: $boxName'));
        }
      },
    );
  }

  // التحقق من وجود قيمة في صندوق معين
  Future<Either<AppException, bool>> containsKey(String boxName, String key) async {
    final boxOrError = await openBox(boxName);
    return boxOrError.fold(
          (error) => Left(error),
          (box) {
        try {
          final contains = box.containsKey(key);
          return Right(contains);
        } catch (e) {
          return Left(NotFoundValueException('Failed to check key in box: $boxName'));
        }
      },
    );
  }

  // مسح جميع القيم من صندوق معين
  Future<Either<AppException, Unit>> clearBox(String boxName) async {
    final boxOrError = await openBox(boxName);
    return boxOrError.fold(
          (error) => Left(error),
          (box) async {
        try {
          await box.clear();
          return const Right(unit);
        } catch (e) {
          return Left(ClearBoxException('Failed to clear box: $boxName'));
        }
      },
    );
  }

  Future<Stream<BoxEvent>?> listenToBox(String boxName, String key) async {
    try {
      // Await the result of _openBox, which returns a Future<Either<AppException, Box>>
      final boxOrError = await openBox(boxName);

      // Now you can use fold to handle the Either<AppException, Box>
      return boxOrError.fold(
            (error) => null, // Handle error case, you could log or return a default value
            (box) {
          return box.watch(key: key); // Return the stream of box events
        },
      );
    } catch (e) {
      return null; // Handle any unexpected errors here
    }
  }
}
