import 'package:flutter_bloc/flutter_bloc.dart';

part 'choice_chip_state.dart';

class ChoiceChipCubit extends Cubit<ChoiceChipState> {
  ChoiceChipCubit({String? initialValue, required List<ChoiceChipItem> items})
      : super(ChoiceChipState(
    selectedValue: initialValue ?? items.first.value,
    items: items,
  ));

  void selectItem(String value) {
    emit(state.copyWith(selectedValue: value));
  }

  void updateItems(List<ChoiceChipItem> newItems) {
    emit(state.copyWith(items: newItems));
  }

  void reset() {
    emit(state.copyWith(selectedValue: state.items.first.value));
  }
}