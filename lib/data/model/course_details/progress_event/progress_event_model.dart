import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'progress_event_model.g.dart';

@JsonSerializable(createToJson: false)
class ProgressEventModel extends Equatable {
  const ProgressEventModel({
    required this.clientEventId,
    required this.accepted,
    this.duplicateReplay,
    required this.progressSequence,
    required this.highestWatchedSeconds,
    required this.lessonProgressStatus,
  });

  final String clientEventId;
  final String lessonProgressStatus;
  final bool accepted;
  final bool? duplicateReplay;
  final int progressSequence;
  final int highestWatchedSeconds;

  factory ProgressEventModel.fromJson(Map<String, dynamic> json) =>
      _$ProgressEventModelFromJson(json);

  @override
  List<Object?> get props => [
    clientEventId,
    accepted,
    duplicateReplay,
    progressSequence,
    highestWatchedSeconds,
    lessonProgressStatus,
  ];
}
