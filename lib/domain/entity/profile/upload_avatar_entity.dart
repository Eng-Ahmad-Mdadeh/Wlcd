import 'package:equatable/equatable.dart';

class UploadAvatarEntity extends Equatable {
  const UploadAvatarEntity({
    required this.filePath,
  });

  final String filePath;

  @override
  List<Object?> get props => [filePath];
}
