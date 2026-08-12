import 'package:wlcd/core/extension/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/extension/remove_zero_from_number.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/presentation/cubit/code_check/code_check_cubit.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';

import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/app_values.dart';

class PhoneSection extends StatelessWidget {
  const PhoneSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: AppPaddingHeight.p55,
        bottom: AppPaddingHeight.p65,
      ),
      child: Column(
        children: [
          BodyTitle(
            text: context.loc.otp_sent_to,
            fontWeight: AppFontWeight.regular,
            color: AppColors.blackText,
            fontSize: AppFontSize.s16,
          ),
          SizedBox(height: AppHeight.h10),
          BlocBuilder<CodeCheckCubit, CodeCheckState>(
            builder: (context, state) {
              return Directionality(
                textDirection: TextDirection.ltr,
                child: BodyTitle(
                  text: "${state.dialCode}-${state.phone.removeZero}",
                  fontWeight: AppFontWeight.bold,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
