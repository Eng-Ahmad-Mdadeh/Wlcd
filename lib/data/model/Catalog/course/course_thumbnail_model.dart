import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_thumbnail_model.g.dart';

@JsonSerializable(createToJson: false)
class CourseThumbnailModel extends Equatable {
  const CourseThumbnailModel({
    required this.mediaId,
    required this.url,
    required this.deliveryType,
    required this.mimeType,
    required this.expiresAt,
    required this.cachePolicy,
    required this.fileName,
    required this.sizeBytes,
    required this.width,
    required this.height,
  });

  final String mediaId;
  final String url;
  final String deliveryType;
  final String mimeType;
  final DateTime? expiresAt;
  final String cachePolicy;
  final String fileName;
  final int sizeBytes;
  final int width;
  final int height;

  factory CourseThumbnailModel.fromJson(Map<String, dynamic> json) =>
      _$CourseThumbnailModelFromJson(json);

  @override
  List<Object?> get props => [
    mediaId,
    url,
    deliveryType,
    mimeType,
    expiresAt,
    cachePolicy,
    fileName,
    sizeBytes,
    width,
    height,
  ];
}
