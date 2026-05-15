part of "logout_bloc.dart";

sealed class ILogoutState extends Equatable {
  const ILogoutState();
}

final class LogoutInitial extends ILogoutState {
  @override
  List<Object> get props => [];
}

final class LogoutLoading extends ILogoutState {
  @override
  List<Object> get props => [];
}

final class LogoutLoaded extends ILogoutState {

  const LogoutLoaded();

  @override
  List<Object?> get props => [];
}

final class LogoutFailed extends ILogoutState {
  final String message;

  const LogoutFailed(this.message);

  @override
  List<Object> get props => [message];
}
