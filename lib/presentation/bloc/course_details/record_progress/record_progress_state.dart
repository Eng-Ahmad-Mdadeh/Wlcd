part of 'record_progress_bloc.dart';

sealed class IRecordProgressState extends Equatable {
  const IRecordProgressState();
}

final class RecordProgressInitial extends IRecordProgressState {
  const RecordProgressInitial();
  @override
  List<Object?> get props => const [];
}

final class RecordProgressLoading extends IRecordProgressState {
  const RecordProgressLoading();
  @override
  List<Object?> get props => const [];
}

final class RecordProgressLoaded extends IRecordProgressState {
  const RecordProgressLoaded(this.recordProgress);

  final ProgressEventModel? recordProgress;

  @override
  List<Object?> get props => [recordProgress];
}

final class RecordProgressFailed extends IRecordProgressState {
  const RecordProgressFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
