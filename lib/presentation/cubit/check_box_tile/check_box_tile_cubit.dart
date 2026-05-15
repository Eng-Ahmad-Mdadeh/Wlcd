import 'package:flutter_bloc/flutter_bloc.dart';


class CheckBoxTileCubit extends Cubit<Map<String, bool>> {
  CheckBoxTileCubit() : super({});

  void toggleCheckboxTile(String key, bool value) {
    final newState = Map<String, bool>.from(state);
    newState[key] = value;
    emit(newState);
  }

  bool getValue(String key) {
    return state[key] ?? false;
  }

  void reset() {
    emit({});
  }
}