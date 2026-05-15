
part of 'login_bloc.dart';

sealed class ILoginEvent extends Equatable {
  const ILoginEvent();
}

final class LoginEvent extends ILoginEvent {
  final AuthEntity entity;

  const LoginEvent(this.entity);

  @override
  List<Object?> get props => [entity];
}
