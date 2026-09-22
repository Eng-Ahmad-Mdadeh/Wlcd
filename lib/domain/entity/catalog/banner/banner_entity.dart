import 'package:equatable/equatable.dart';

class BannerEntity extends Equatable {
  const BannerEntity({
    required this.bannerId,
    required this.image,
    this.categoryId,
    this.courseId,
    this.link,
  });

  final String bannerId;
  final String image;
  final String? categoryId;
  final String? courseId;
  final String? link;

  @override
  List<Object?> get props => [bannerId, image, categoryId, courseId, link];
}
