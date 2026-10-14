import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contract_json_model.g.dart';

@JsonSerializable(createToJson: false)
class ContractJsonModel extends Equatable {
  const ContractJsonModel(this.value);
  @JsonKey(readValue: _readResponse)
  final Map<String, dynamic> value;

  factory ContractJsonModel.fromJson(Map<String, dynamic> json) =>
      _$ContractJsonModelFromJson(json);

  @override
  List<Object?> get props => [value];
}

Object? _readResponse(Map json, String key) => json;
