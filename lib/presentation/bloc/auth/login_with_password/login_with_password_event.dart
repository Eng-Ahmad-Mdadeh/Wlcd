part of 'login_with_password_bloc.dart';

sealed class ILoginWithPasswordEvent extends Equatable {
  const ILoginWithPasswordEvent();
}

final class SubmitLoginWithPasswordEvent extends ILoginWithPasswordEvent {
  const SubmitLoginWithPasswordEvent(this.entity);
  final LoginWithPasswordEntity entity;
  @override
  List<Object?> get props => [entity];
}
