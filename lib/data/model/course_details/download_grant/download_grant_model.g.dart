// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_grant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DownloadGrantModel _$DownloadGrantModelFromJson(Map<String, dynamic> json) =>
    DownloadGrantModel(
      resourceId: json['resourceId'] as String,
      downloadUrl: json['downloadUrl'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      mimeType: json['mimeType'] as String,
      fileName: json['fileName'] as String?,
      sizeBytes: (json['sizeBytes'] as num).toInt(),
      checksum: json['checksum'] as String?,
    );
