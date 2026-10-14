import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'download_grant_model.g.dart';

@JsonSerializable(createToJson: false)
class DownloadGrantModel extends Equatable {
  const DownloadGrantModel({
    required this.resourceId,
    required this.downloadUrl,
    required this.expiresAt,
    required this.mimeType,
    this.fileName,
    required this.sizeBytes,
    this.checksum,
  });

  final String resourceId;
  final String downloadUrl;
  final String mimeType;
  final DateTime expiresAt;
  final String? fileName;
  final String? checksum;
  final int sizeBytes;

  factory DownloadGrantModel.fromJson(Map<String, dynamic> json) =>
      _$DownloadGrantModelFromJson(json);

  @override
  List<Object?> get props => [
    resourceId,
    downloadUrl,
    expiresAt,
    mimeType,
    fileName,
    sizeBytes,
    checksum,
  ];
}
