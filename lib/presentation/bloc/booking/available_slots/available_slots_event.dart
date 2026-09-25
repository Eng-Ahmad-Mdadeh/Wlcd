part of 'available_slots_bloc.dart';

sealed class IAvailableSlotsEvent extends Equatable {
  const IAvailableSlotsEvent();
}

final class LoadAvailableSlotsEvent extends IAvailableSlotsEvent {
  const LoadAvailableSlotsEvent(this.entity);

  final GetAvailableSlotsEntity entity;

  @override
  List<Object?> get props => [entity];
}
