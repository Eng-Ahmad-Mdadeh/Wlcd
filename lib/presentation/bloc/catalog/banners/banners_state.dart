part of 'banners_bloc.dart';

sealed class IBannersState extends Equatable {
  const IBannersState();
}

final class BannersInitial extends IBannersState {
  const BannersInitial();
  @override
  List<Object?> get props => const [];
}

final class BannersLoading extends IBannersState {
  const BannersLoading();
  @override
  List<Object?> get props => const [];
}

final class BannersLoaded extends IBannersState {
  const BannersLoaded(this.banners);
  final BannersModel? banners;
  @override
  List<Object?> get props => [banners];
}

final class BannersFailed extends IBannersState {
  const BannersFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
