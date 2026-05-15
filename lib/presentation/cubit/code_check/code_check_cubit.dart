import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'code_check_state.dart';

class CodeCheckCubit extends Cubit<CodeCheckState> {
  CodeCheckCubit() : super(CodeCheckEndDateInitial(DateTime.now().add(const Duration(minutes: 5)), '', false, 'sms',''));

  void resetTime() => emit(
    CodeCheckEndDateChanged(DateTime.now().add(const Duration(minutes: 5)), state.phone, state.rememberMe, state.type,state.dialCode),
  );

  void endTime() => emit(
    CodeCheckEndDateChanged(
      DateTime.now(),
      state.phone,
      state.rememberMe,
      state.type,
      state.dialCode,
    ),
  );

  void setPhone(String mobile) => emit(
    CodeCheckEndDateInitial(DateTime.now().add(const Duration(minutes: 5)), mobile, state.rememberMe, state.type,state.dialCode),
  );
  void setType(String type,String dialCode) => emit(
    CodeCheckEndDateInitial(DateTime.now().add(const Duration(minutes: 5)), state.phone, state.rememberMe, type,dialCode),
  );
  void setRememberMe(bool value) => emit(
    CodeCheckEndDateInitial(DateTime.now().add(const Duration(minutes: 5)), state.phone, value, state.type,state.dialCode),
  );

  bool get done => state.endDate.difference(DateTime.now()).inMinutes <= 0;

  bool get lessThan5 => state.endDate.difference(DateTime.now()).inMinutes <= 5;
}
