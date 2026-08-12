import 'package:wlcd/core/extension/localization_extension.dart';
import 'package:wlcd/domain/entity/auth/auth_entity.dart';
import 'package:wlcd/presentation/bloc/auth/check_code/check_code_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:wlcd/core/extension/remove_zero_from_number.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/cubit/code_check/code_check_cubit.dart';
import 'package:wlcd/presentation/widgets/retry_widget.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';

class ResendCodeSection extends StatelessWidget {
  const ResendCodeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CodeCheckCubit, CodeCheckState>(
      builder: (context, state) {
        final isYellow = context.read<CodeCheckCubit>().lessThan5;
        final done = context.read<CodeCheckCubit>().done;

        return Padding(
          padding: EdgeInsetsDirectional.only(
            top: AppPaddingHeight.p20,
          ),
          child: Column(
            children: [
              BodyTitle(
                text: context.loc.otp_resend,
                color: AppColors.greyText,
                fontSize: AppFontSize.s16,
              ),
              SizedBox(height: AppHeight.h7),
              if (done)
                RetryWidget(
                  showText: false,
                  onReload: () {
                    context.read<CodeCheckCubit>().resetTime();

                    context.read<CheckCodeBloc>().add(
                      ResendCodeEvent(
                        AuthEntity(
                          phone: "${state.dialCode}${(state.phone).removeZero}",
                          rememberMe: state.rememberMe,
                          typeMessage: state.type,
                        ),
                      ),
                    );
                  },
                )
              else
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: TimerCountdown(
                    spacerWidth: 2,
                    endTime: state.endDate,
                    format: CountDownTimerFormat.minutesSeconds,
                    enableDescriptions: false,
                    timeTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: isYellow ? AppColors.primary : AppColors.lightBlue,
                      fontSize: AppFontSize.s16,
                    ),
                    onEnd: context.read<CodeCheckCubit>().endTime,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
