import 'package:equatable/equatable.dart';

class UploadAvatarEntity extends Equatable {
  const UploadAvatarEntity({this.file});

  final List<Map<String, dynamic>>? file;

  UploadAvatarEntity copyWith({List<Map<String, dynamic>>? file}) {
    return UploadAvatarEntity(file: file ?? this.file);
  }

  @override
  List<Object?> get props => [file];
}
