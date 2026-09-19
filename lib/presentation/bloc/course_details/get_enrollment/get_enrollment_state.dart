part of 'get_enrollment_bloc.dart';

sealed class IGetEnrollmentState extends Equatable {
  const IGetEnrollmentState();
}

final class GetEnrollmentInitial extends IGetEnrollmentState {
  const GetEnrollmentInitial();
  @override
  List<Object?> get props => const [];
}

final class GetEnrollmentLoading extends IGetEnrollmentState {
  const GetEnrollmentLoading();
  @override
  List<Object?> get props => const [];
}

final class GetEnrollmentLoaded extends IGetEnrollmentState {
  const GetEnrollmentLoaded(this.getEnrollment);

  final EnrollmentModel? getEnrollment;

  @override
  List<Object?> get props => [getEnrollment];
}

final class GetEnrollmentFailed extends IGetEnrollmentState {
  const GetEnrollmentFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
