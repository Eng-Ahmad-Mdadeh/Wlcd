import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/cubit/remember_me/remember_me_cubit.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';

class RememberMeCheckbox extends StatelessWidget {
  const RememberMeCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<RememberMeCubit, bool?>(
          builder: (context, state) {
            return SizedBox(
              width: AppWidth.w20,
              height: AppHeight.h20,
              child: Checkbox(
                value: state,
                activeColor: AppColors.primary,
                onChanged: (value) {
                  context.read<RememberMeCubit>().toggleRememberMe(value ?? false);
                },
              ),
            );
          },
        ),
        SizedBox(width: AppWidth.w7),
        BodyTitle(
          text: "البقاء مسجلا الدخول",
          fontWeight: AppFontWeight.medium,
          fontSize: AppFontSize.s14,
        ),
      ],
    );
  }
}
