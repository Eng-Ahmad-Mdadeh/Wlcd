// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playback_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaybackModel _$PlaybackModelFromJson(Map<String, dynamic> json) =>
    PlaybackModel(
      courseId: json['courseId'] as String,
      lessonId: json['lessonId'] as String,
      playbackUrl: json['playbackUrl'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      mediaType: json['mediaType'] as String,
    );
