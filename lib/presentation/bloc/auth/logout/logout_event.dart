part of "logout_bloc.dart";

sealed class ILogoutEvent extends Equatable {
  const ILogoutEvent();
}

final class LogoutEvent extends ILogoutEvent {
  const LogoutEvent();

  @override
  List<Object?> get props => [];
}
