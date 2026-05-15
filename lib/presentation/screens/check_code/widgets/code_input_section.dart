import 'package:wlcd/domain/entity/auth/auth_entity.dart';
import 'package:wlcd/presentation/bloc/auth/check_code/check_code_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/extension/remove_zero_from_number.dart';

import 'package:wlcd/presentation/cubit/code_check/code_check_cubit.dart';

import '../../../../core/resources/app_values.dart';
import 'code_text_field.dart';

class CodeInputSection extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController codeController;

  const CodeInputSection({
    super.key,
    required this.formKey,
    required this.codeController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppWidth.w50),
        child: BlocBuilder<CodeCheckCubit, CodeCheckState>(
          builder: (context, state) {
            return CodeTextField(
              controller: codeController,
              onCompleted: (value) async {
                if (formKey.currentState!.validate()) {
                  // final handler = FirebaseNotificationsHandler();
                  // final fcmToken = handler.cachedFcmToken;
                  // handler.refreshFcmToken();
                  // final fcmToken = await handler.refreshFcmToken();
                  if (context.mounted) {
                    context.read<CheckCodeBloc>().add(
                      CheckCodeEvent(
                        AuthEntity(
                          phone: "${state.dialCode}${(state.phone).removeZero}",
                          code: value,
                          rememberMe: state.rememberMe,
                          // fcm: fcmToken,
                        ),
                      ),
                    );
                  }
                }
              },
            );
          },
        ),
      ),
    );
  }
}
