import 'package:equatable/equatable.dart';

class GetInstructorEntity extends Equatable {
  const GetInstructorEntity({required this.instructorId})
    : assert(instructorId != '', 'instructorId must not be empty');

  final String instructorId;

  @override
  List<Object?> get props => [instructorId];
}
