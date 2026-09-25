part of 'available_slots_bloc.dart';

sealed class IAvailableSlotsState extends Equatable {
  const IAvailableSlotsState();
}

final class AvailableSlotsInitial extends IAvailableSlotsState {
  const AvailableSlotsInitial();

  @override
  List<Object?> get props => const [];
}

final class AvailableSlotsLoading extends IAvailableSlotsState {
  const AvailableSlotsLoading();

  @override
  List<Object?> get props => const [];
}

final class AvailableSlotsLoaded extends IAvailableSlotsState {
  const AvailableSlotsLoaded(this.availableSlots);

  final AvailableSlotsModel? availableSlots;

  @override
  List<Object?> get props => [availableSlots];
}

final class AvailableSlotsFailed extends IAvailableSlotsState {
  const AvailableSlotsFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
