// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProgressEventModel _$ProgressEventModelFromJson(Map<String, dynamic> json) =>
    ProgressEventModel(
      clientEventId: json['clientEventId'] as String,
      accepted: json['accepted'] as bool,
      duplicateReplay: json['duplicateReplay'] as bool?,
      progressSequence: (json['progressSequence'] as num).toInt(),
      highestWatchedSeconds: (json['highestWatchedSeconds'] as num).toInt(),
      lessonProgressStatus: json['lessonProgressStatus'] as String,
    );
