import 'package:flutter_bloc/flutter_bloc.dart';

class CheckBoxCubit extends Cubit<bool> {
  CheckBoxCubit({bool initialValue = false}) : super(initialValue);

  void toggleUCheckBox(bool v) => emit(v);
}
