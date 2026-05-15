import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/presentation/cubit/check_box/check_box_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomCheckBox extends StatelessWidget {
  final void Function(bool?)? onChanged;
  final bool value;

  const CustomCheckBox({super.key, this.onChanged, this.value = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CheckBoxCubit>(
      create: (context) => CheckBoxCubit(initialValue: value),
      child: BlocBuilder<CheckBoxCubit, bool>(
        builder: (context, state) {
          return Checkbox(
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            value: state,
            activeColor: AppColors.primary,
            onChanged: (value) {
              if (value == null) return;
              context.read<CheckBoxCubit>().toggleUCheckBox(value);
              onChanged?.call(value);
            },
          );
        },
      ),
    );
  }
}
