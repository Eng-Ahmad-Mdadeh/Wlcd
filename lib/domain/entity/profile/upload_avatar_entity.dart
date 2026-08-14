import 'package:equatable/equatable.dart';

class UploadAvatarEntity extends Equatable {
  const UploadAvatarEntity({
    required this.filePath,
    required this.idempotencyKey,
  });

  final String filePath;
  final String idempotencyKey;

  Map<String, dynamic> get headers => {'Idempotency-Key': idempotencyKey};

  @override
  List<Object?> get props => [filePath, idempotencyKey];
}
