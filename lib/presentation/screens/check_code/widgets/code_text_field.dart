import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/presentation/cubit/code_check/code_check_cubit.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/app_fonts.dart';
import '../../../../core/resources/app_values.dart';

class CodeTextField extends StatelessWidget {
  final Function(String) onCompleted;

  const CodeTextField({
    super.key,
    required this.controller,
    required this.onCompleted,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        length: 6,
        readOnly: context.read<CodeCheckCubit>().done,
        pinContentAlignment: Alignment.center,
        controller: controller,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        scrollPadding: EdgeInsets.zero,

        animationDuration: const Duration(milliseconds: 250),
        onCompleted: onCompleted,
        keyboardType: TextInputType.number,
        // androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
        defaultPinTheme: PinTheme(
          width: AppWidth.w40,
          // height: AppHeight.h80,
          textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: AppFontSize.s30,
              ),
          decoration: BoxDecoration(
            // color: AppColors.mintGreen,
            border: Border(
                bottom: BorderSide(
              width: .7,
              color: AppColors.grey,
            )),
          ),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+')),
        ],
        validator: (value) {
          if (value!.isEmpty) {
            return "الرجاء إدخال رمز التحقق";
          }
          if (value.length < 4) {
            return "الرجاء إدخال رمز التحقق صالح";
          }
          return null;
        },
      ),
    );
  }
}
