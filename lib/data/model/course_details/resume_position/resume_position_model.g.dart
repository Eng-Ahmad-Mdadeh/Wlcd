// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_position_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResumePositionModel _$ResumePositionModelFromJson(Map<String, dynamic> json) =>
    ResumePositionModel(
      enrollmentId: json['enrollmentId'] as String,
      lessonId: json['lessonId'] as String,
      lessonProgressStatus: json['lessonProgressStatus'] as String,
      highestWatchedSeconds: (json['highestWatchedSeconds'] as num).toInt(),
      mediaOffsetSeconds: (json['mediaOffsetSeconds'] as num?)?.toInt(),
      progressSequence: (json['progressSequence'] as num).toInt(),
      lastProgressAt: json['lastProgressAt'] == null
          ? null
          : DateTime.parse(json['lastProgressAt'] as String),
    );
