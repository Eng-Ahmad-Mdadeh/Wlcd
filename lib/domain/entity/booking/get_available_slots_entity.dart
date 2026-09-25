import 'package:equatable/equatable.dart';

class GetAvailableSlotsEntity extends Equatable {
  const GetAvailableSlotsEntity({
    required this.instructorId,
    this.from,
    this.to,
    this.timeZone,
  }) : assert(instructorId != '', 'instructorId must not be empty');

  final String instructorId;
  final String? from;
  final String? to;
  final String? timeZone;

  Map<String, dynamic> toQueryParameters() => {
    if (from?.isNotEmpty ?? false) 'from': from,
    if (to?.isNotEmpty ?? false) 'to': to,
    if (timeZone?.isNotEmpty ?? false) 'timeZone': timeZone,
  };

  GetAvailableSlotsEntity copyWith({
    String? instructorId,
    String? from,
    String? to,
    String? timeZone,
    bool clearFrom = false,
    bool clearTo = false,
    bool clearTimeZone = false,
  }) => GetAvailableSlotsEntity(
    instructorId: instructorId ?? this.instructorId,
    from: clearFrom ? null : from ?? this.from,
    to: clearTo ? null : to ?? this.to,
    timeZone: clearTimeZone ? null : timeZone ?? this.timeZone,
  );

  @override
  List<Object?> get props => [instructorId, from, to, timeZone];
}
