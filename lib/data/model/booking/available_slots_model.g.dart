// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_slots_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailableSlotModel _$AvailableSlotModelFromJson(Map<String, dynamic> json) =>
    AvailableSlotModel(
      availabilitySlotId: json['availabilitySlotId'] as String?,
      instructorId: json['instructorId'] as String?,
      startsAt: json['startsAt'] == null
          ? null
          : DateTime.parse(json['startsAt'] as String),
      endsAt: json['endsAt'] == null
          ? null
          : DateTime.parse(json['endsAt'] as String),
      displayTimeZoneId: json['displayTimeZoneId'] as String?,
      slotState: json['slotState'] as String?,
      version: (json['version'] as num?)?.toInt(),
    );

AvailableSlotsDayModel _$AvailableSlotsDayModelFromJson(
  Map<String, dynamic> json,
) => AvailableSlotsDayModel(
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  slots:
      (json['slots'] as List<dynamic>?)
          ?.map((e) => AvailableSlotModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

AvailableSlotsModel _$AvailableSlotsModelFromJson(Map<String, dynamic> json) =>
    AvailableSlotsModel(
      displayTimeZoneId: json['displayTimeZoneId'] as String?,
      instructorTimeZoneId: json['instructorTimeZoneId'] as String?,
      learnerTimeZoneId: json['learnerTimeZoneId'] as String?,
      data:
          (json['data'] as List<dynamic>?)
              ?.map(
                (e) => AvailableSlotsDayModel.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          const [],
    );
