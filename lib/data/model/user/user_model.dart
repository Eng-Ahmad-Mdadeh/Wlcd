import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(createToJson: false)
class UserModel extends Equatable {
  const UserModel({
     this.id,
     this.stableName,
     this.name,
     this.email,
     this.phone,
     this.gender,
     this.countryId,
     this.emailVerifiedAt,
     this.deletedAt,
     this.updatedAt,
     this.profileComplete,
     this.country,
     this.state,
     this.purchaseDate,

  });

  final String? id;
  @JsonKey(name: 'stable_name')
  final String? stableName;
  final String? name;
  final dynamic email;
  final String? phone;
  final dynamic gender;

  @JsonKey(name: 'country_id')
  final dynamic countryId;

  @JsonKey(name: 'email_verified_at')
  final dynamic emailVerifiedAt;

  @JsonKey(name: 'deleted_at')
  final dynamic deletedAt;

  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @JsonKey(name: 'profile_complete')
  final bool? profileComplete;
  final String? country;
  final String? state;
  @JsonKey(name: 'purchase_date')
  final String? purchaseDate;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  @override
  List<Object?> get props => [
    id,
    stableName,
    name,
    email,
    phone,
    gender,
    countryId,
    emailVerifiedAt,
    deletedAt,
    updatedAt,
    profileComplete,
    country,
    state,
    purchaseDate,
  ];
}
