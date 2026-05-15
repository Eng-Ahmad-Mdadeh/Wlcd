import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/routes/app_routes_imports.dart';

class CustomSwitch extends StatelessWidget {
  final String title;
  final String? subTitle;
  final FontWeight? titleWeight;
  final double? titleSize;
  final bool req;
  final Widget? child;
  final Function(bool) onChanged;
  final bool initialValue;

  const CustomSwitch({
    super.key,
    required this.title,
    this.subTitle,
    required this.onChanged,
    this.titleSize,
    this.titleWeight,
    this.req = false,
    this.child,
    this.initialValue = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReservationSwitchCubit(initialValue: initialValue),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: AppWidth.w20,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                // 👈 Wrap Column with Expanded
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      overflow: TextOverflow.visible,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: title,
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: AppColors.primary,
                              fontSize: AppFontSize.s15,
                              fontWeight: titleWeight,
                            ),
                          ),
                          if (req)
                            TextSpan(
                              text: ' *',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: AppColors.red,
                                fontSize: AppFontSize.s18,
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (subTitle != null)
                      BodyTitle(
                        text: subTitle,
                        fontWeight: AppFontWeight.regular,
                        color: AppColors.greyText,
                        fontSize: AppFontSize.s12,
                      ),
                  ],
                ),
              ),
              BlocBuilder<ReservationSwitchCubit, bool>(
                builder: (context, state) {
                  return Transform.scale(
                    scale: .9.sp,
                    child: SizedBox(
                      height: AppHeight.h35,
                      width: AppWidth.w50,
                      child: Switch(
                        value: state,
                        activeColor: AppColors.primary,
                        inactiveTrackColor: AppColors.backGround,
                        inactiveThumbColor: AppColors.grey,
                        onChanged: (value) {
                          context.read<ReservationSwitchCubit>().switchChanged(value);
                          onChanged.call(value);
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          BlocBuilder<ReservationSwitchCubit, bool>(
            builder: (context, state) {
              return state && child != null ? child!.animate().fadeIn() : const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}

class ReservationSwitchCubit extends Cubit<bool> {
  ReservationSwitchCubit({required bool initialValue}) : super(initialValue);

  void switchChanged(bool v) => emit(v);
}
