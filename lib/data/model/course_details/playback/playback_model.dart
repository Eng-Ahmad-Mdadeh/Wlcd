import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'playback_model.g.dart';

@JsonSerializable(createToJson: false)
class PlaybackModel extends Equatable {
  const PlaybackModel({
    required this.courseId,
    required this.lessonId,
    required this.playbackUrl,
    required this.expiresAt,
    required this.mediaType,
  });

  final String courseId;
  final String lessonId;
  final String playbackUrl;
  final String mediaType;
  final DateTime expiresAt;

  factory PlaybackModel.fromJson(Map<String, dynamic> json) =>
      _$PlaybackModelFromJson(json);

  @override
  List<Object?> get props => [
    courseId,
    lessonId,
    playbackUrl,
    expiresAt,
    mediaType,
  ];
}
