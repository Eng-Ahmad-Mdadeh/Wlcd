import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_price_model.g.dart';

@JsonSerializable(createToJson: false)
class CoursePriceModel extends Equatable {
  const CoursePriceModel({
    required this.amount,
    required this.currency,
    required this.displayLabel,
  });

  final String amount;
  final String currency;
  final String displayLabel;

  factory CoursePriceModel.fromJson(Map<String, dynamic> json) =>
      _$CoursePriceModelFromJson(json);

  @override
  List<Object?> get props => [amount, currency, displayLabel];
}
