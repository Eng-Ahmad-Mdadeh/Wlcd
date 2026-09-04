import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wlcd/data/model/profile/media_projection/media_projection_model.dart';

part 'profile_model.g.dart';

@JsonSerializable(createToJson: false)
class ProfileModel extends Equatable {
  const ProfileModel({
    required this.accountId,
    required this.displayName,
    required this.status,
    required this.profileComplete,
    this.email,
    this.phone,
    this.locale,
    this.avatarMediaId,
    this.avatar,
    this.onboardingComplete,
    this.version,
    this.etag,
  });

  final String accountId;
  final String displayName;
  final String? email;
  final String? phone;
  final String? locale;
  final String? avatarMediaId;
  final MediaProjectionModel? avatar;
  final String status;
  final bool profileComplete;
  final bool? onboardingComplete;
  final int? version;
  final String? etag;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  @override
  List<Object?> get props => [
    accountId,
    displayName,
    email,
    phone,
    locale,
    avatarMediaId,
    avatar,
    status,
    profileComplete,
    onboardingComplete,
    version,
    etag,
  ];
}
