part of 'enroll_free_bloc.dart';

sealed class IEnrollFreeState extends Equatable {
  const IEnrollFreeState();
}

final class EnrollFreeInitial extends IEnrollFreeState {
  const EnrollFreeInitial();
  @override
  List<Object?> get props => const [];
}

final class EnrollFreeLoading extends IEnrollFreeState {
  const EnrollFreeLoading();
  @override
  List<Object?> get props => const [];
}

final class EnrollFreeLoaded extends IEnrollFreeState {
  const EnrollFreeLoaded(this.enrollFree);

  final EnrollmentModel? enrollFree;

  @override
  List<Object?> get props => [enrollFree];
}

final class EnrollFreeFailed extends IEnrollFreeState {
  const EnrollFreeFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
