import 'package:equatable/equatable.dart';

class GlobalPlatformEntity extends Equatable {
  const GlobalPlatformEntity({
    required this.id,
    required this.title,
    required this.tag,
    required this.image,
    required this.description,
    required this.link,
  });

  final String id;
  final String title;
  final String tag;
  final String image;
  final String description;
  final String link;

  @override
  List<Object?> get props => [id, title, tag, image, description, link];
}
