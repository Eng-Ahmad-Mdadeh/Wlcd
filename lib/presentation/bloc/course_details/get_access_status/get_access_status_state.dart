part of 'get_access_status_bloc.dart';

sealed class IGetAccessStatusState extends Equatable {
  const IGetAccessStatusState();
}

final class GetAccessStatusInitial extends IGetAccessStatusState {
  const GetAccessStatusInitial();
  @override
  List<Object?> get props => const [];
}

final class GetAccessStatusLoading extends IGetAccessStatusState {
  const GetAccessStatusLoading();
  @override
  List<Object?> get props => const [];
}

final class GetAccessStatusLoaded extends IGetAccessStatusState {
  const GetAccessStatusLoaded(this.getAccessStatus);

  final ContractJsonModel? getAccessStatus;

  @override
  List<Object?> get props => [getAccessStatus];
}

final class GetAccessStatusFailed extends IGetAccessStatusState {
  const GetAccessStatusFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
