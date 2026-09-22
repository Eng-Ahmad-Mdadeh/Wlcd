import 'package:json_annotation/json_annotation.dart';
import 'package:wlcd/domain/entity/catalog/banner/banner_entity.dart';

part 'banners_model.g.dart';

@JsonSerializable(createToJson: false)
class BannerModel extends BannerEntity {
  const BannerModel({
    required super.bannerId,
    required super.image,
    super.categoryId,
    super.courseId,
    super.link,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);
}

class BannersModel {
  const BannersModel({required this.banners});

  final List<BannerModel> banners;

  factory BannersModel.fromJson(Object? json) => BannersModel(
    banners: _bannersJson(json)
        .map((item) => BannerModel.fromJson(item as Map<String, dynamic>))
        .toList(),
  );

  static List<dynamic> _bannersJson(Object? json) {
    if (json is List<dynamic>) return json;

    if (json is Map<String, dynamic>) {
      final banners = json['data'] ?? json['banners'];
      if (banners is List<dynamic>) return banners;
    }

    throw const FormatException(
      'Banners response must contain a list of banners',
    );
  }
}
