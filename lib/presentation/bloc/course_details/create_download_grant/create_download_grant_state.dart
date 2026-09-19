part of 'create_download_grant_bloc.dart';

sealed class ICreateDownloadGrantState extends Equatable {
  const ICreateDownloadGrantState();
}

final class CreateDownloadGrantInitial extends ICreateDownloadGrantState {
  const CreateDownloadGrantInitial();
  @override
  List<Object?> get props => const [];
}

final class CreateDownloadGrantLoading extends ICreateDownloadGrantState {
  const CreateDownloadGrantLoading();
  @override
  List<Object?> get props => const [];
}

final class CreateDownloadGrantLoaded extends ICreateDownloadGrantState {
  const CreateDownloadGrantLoaded(this.createDownloadGrant);

  final DownloadGrantModel? createDownloadGrant;

  @override
  List<Object?> get props => [createDownloadGrant];
}

final class CreateDownloadGrantFailed extends ICreateDownloadGrantState {
  const CreateDownloadGrantFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
