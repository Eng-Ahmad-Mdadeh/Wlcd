part of 'banners_bloc.dart';

sealed class IBannersEvent extends Equatable {
  const IBannersEvent();
}

final class LoadBannersEvent extends IBannersEvent {
  const LoadBannersEvent();

  @override
  List<Object?> get props => const [];
}
