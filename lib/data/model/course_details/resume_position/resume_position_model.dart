import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'resume_position_model.g.dart';

@JsonSerializable(createToJson: false)
class ResumePositionModel extends Equatable {
  const ResumePositionModel({
    required this.enrollmentId,
    required this.lessonId,
    required this.lessonProgressStatus,
    required this.highestWatchedSeconds,
    this.mediaOffsetSeconds,
    required this.progressSequence,
    this.lastProgressAt,
  });

  final String enrollmentId;
  final String lessonId;
  final String lessonProgressStatus;
  final int highestWatchedSeconds;
  final int progressSequence;
  final int? mediaOffsetSeconds;
  final DateTime? lastProgressAt;

  factory ResumePositionModel.fromJson(Map<String, dynamic> json) =>
      _$ResumePositionModelFromJson(json);

  @override
  List<Object?> get props => [
    enrollmentId,
    lessonId,
    lessonProgressStatus,
    highestWatchedSeconds,
    mediaOffsetSeconds,
    progressSequence,
    lastProgressAt,
  ];
}
