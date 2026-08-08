part of 'reset_password_bloc.dart';

sealed class IResetPasswordState extends Equatable {
  const IResetPasswordState();
}
final class ResetPasswordInitial extends IResetPasswordState {
  @override
  List<Object?> get props => [];
}
final class ResetPasswordLoading extends IResetPasswordState {
  @override
  List<Object?> get props => [];
}
final class ResetPasswordLoaded extends IResetPasswordState {
  const ResetPasswordLoaded({required this.result});
  final BaseModel<OperationSuccessModel>? result;
  @override
  List<Object?> get props => [result];
}
final class ResetPasswordFailed extends IResetPasswordState {
  const ResetPasswordFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
