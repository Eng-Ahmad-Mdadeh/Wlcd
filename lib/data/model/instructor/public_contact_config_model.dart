import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'public_contact_config_model.g.dart';

@JsonSerializable(createToJson: false)
class PublicContactChannelModel extends Equatable {
  const PublicContactChannelModel({this.type, this.value});

  final String? type;
  final String? value;

  factory PublicContactChannelModel.fromJson(Map<String, dynamic> json) =>
      _$PublicContactChannelModelFromJson(json);

  @override
  List<Object?> get props => [type, value];
}

@JsonSerializable(createToJson: false)
class PublicContactConfigModel extends Equatable {
  const PublicContactConfigModel({this.channels = const []});

  final List<PublicContactChannelModel> channels;

  factory PublicContactConfigModel.fromJson(Map<String, dynamic> json) =>
      _$PublicContactConfigModelFromJson(json);

  @override
  List<Object?> get props => [channels];
}
