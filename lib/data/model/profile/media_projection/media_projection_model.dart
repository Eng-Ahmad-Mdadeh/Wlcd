import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'media_projection_model.g.dart';

@JsonSerializable(createToJson: false)
class MediaProjectionModel extends Equatable {
  const MediaProjectionModel({this.url, this.mimeType, this.altText});

  final String? url;
  final String? mimeType;
  final String? altText;

  factory MediaProjectionModel.fromJson(Map<String, dynamic> json) =>
      _$MediaProjectionModelFromJson(json);

  @override
  List<Object?> get props => [url, mimeType, altText];
}
