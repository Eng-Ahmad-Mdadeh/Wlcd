import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'available_slots_model.g.dart';

@JsonSerializable(createToJson: false)
class AvailableSlotModel extends Equatable {
  const AvailableSlotModel({
    this.availabilitySlotId,
    this.instructorId,
    this.startsAt,
    this.endsAt,
    this.displayTimeZoneId,
    this.slotState,
    this.version,
  });

  final String? availabilitySlotId;
  final String? instructorId;
  final DateTime? startsAt;
  final DateTime? endsAt;
  final String? displayTimeZoneId;
  final String? slotState;
  final int? version;

  factory AvailableSlotModel.fromJson(Map<String, dynamic> json) =>
      _$AvailableSlotModelFromJson(json);

  @override
  List<Object?> get props => [
    availabilitySlotId,
    instructorId,
    startsAt,
    endsAt,
    displayTimeZoneId,
    slotState,
    version,
  ];
}

@JsonSerializable(createToJson: false)
class AvailableSlotsDayModel extends Equatable {
  const AvailableSlotsDayModel({this.date, this.slots = const []});

  final DateTime? date;
  final List<AvailableSlotModel> slots;

  factory AvailableSlotsDayModel.fromJson(Map<String, dynamic> json) =>
      _$AvailableSlotsDayModelFromJson(json);

  @override
  List<Object?> get props => [date, slots];
}

@JsonSerializable(createToJson: false)
class AvailableSlotsModel extends Equatable {
  const AvailableSlotsModel({
    this.displayTimeZoneId,
    this.instructorTimeZoneId,
    this.learnerTimeZoneId,
    this.data = const [],
  });

  final String? displayTimeZoneId;
  final String? instructorTimeZoneId;
  final String? learnerTimeZoneId;
  final List<AvailableSlotsDayModel> data;

  factory AvailableSlotsModel.fromJson(Map<String, dynamic> json) =>
      _$AvailableSlotsModelFromJson(json);

  @override
  List<Object?> get props => [
    displayTimeZoneId,
    instructorTimeZoneId,
    learnerTimeZoneId,
    data,
  ];
}
