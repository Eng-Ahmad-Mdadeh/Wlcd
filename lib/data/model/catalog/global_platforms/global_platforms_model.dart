import 'package:json_annotation/json_annotation.dart';
import 'package:wlcd/domain/entity/catalog/global_platform/global_platform_entity.dart';

part 'global_platforms_model.g.dart';

@JsonSerializable(createToJson: false)
class GlobalPlatformModel extends GlobalPlatformEntity {
  const GlobalPlatformModel({
    required super.id,
    required super.title,
    required super.tag,
    required super.image,
    required super.description,
    required super.link,
  });

  factory GlobalPlatformModel.fromJson(Map<String, dynamic> json) => _$GlobalPlatformModelFromJson(json);
}

class GlobalPlatformsModel {
  const GlobalPlatformsModel({required this.platforms});

  final List<GlobalPlatformModel> platforms;

  factory GlobalPlatformsModel.fromJson(Object? json) => GlobalPlatformsModel(
    platforms: _platformsJson(json)
        .map((item) => GlobalPlatformModel.fromJson(item as Map<String, dynamic>))
        .toList(),
  );

  static List<dynamic> _platformsJson(Object? json) {
    if (json is List<dynamic>) return json;

    if (json is Map<String, dynamic>) {
      final platforms = json['data'] ??
          json['globalPlatforms'] ??
          json['global_platforms'] ??
          json['platforms'];
      if (platforms is List<dynamic>) return platforms;
    }

    throw const FormatException(
      'Global platforms response must contain a list of platforms',
    );
  }
}
