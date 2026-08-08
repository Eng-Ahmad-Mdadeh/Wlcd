part of 'request_password_reset_bloc.dart';

sealed class IRequestPasswordResetState extends Equatable {
  const IRequestPasswordResetState();
}
final class RequestPasswordResetInitial extends IRequestPasswordResetState {
  @override
  List<Object?> get props => [];
}
final class RequestPasswordResetLoading extends IRequestPasswordResetState {
  @override
  List<Object?> get props => [];
}
final class RequestPasswordResetLoaded extends IRequestPasswordResetState {
  const RequestPasswordResetLoaded({required this.result});
  final BaseModel<OperationSuccessModel>? result;
  @override
  List<Object?> get props => [result];
}
final class RequestPasswordResetFailed extends IRequestPasswordResetState {
  const RequestPasswordResetFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
