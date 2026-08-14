part of 'get_profile_bloc.dart';

sealed class IGetProfileState extends Equatable {
  const IGetProfileState();
}

final class GetProfileInitial extends IGetProfileState {
  @override
  List<Object?> get props => const [];
}

final class GetProfileLoading extends IGetProfileState {
  @override
  List<Object?> get props => const [];
}

final class GetProfileLoaded extends IGetProfileState {
  const GetProfileLoaded({required this.profileModel});

  final BaseModel<ProfileModel>? profileModel;

  @override
  List<Object?> get props => [profileModel];
}

final class GetProfileFailed extends IGetProfileState {
  const GetProfileFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
