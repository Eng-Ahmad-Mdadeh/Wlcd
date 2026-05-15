import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/presentation/cubit/check_box_tile/check_box_tile_cubit.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomCheckboxTile extends StatelessWidget {
  final String uniqueKey;
  final String title;
  final bool? initialValue;
  final ValueChanged<bool>? onChanged;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? secondary;
  final Color? activeColor;
  final Color? checkColor;

  const CustomCheckboxTile({
    super.key,
    required this.uniqueKey,
    required this.title,
    this.initialValue,
    this.onChanged,
    this.contentPadding,
    this.secondary,
    this.activeColor,
    this.checkColor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CheckBoxTileCubit>(
      create: (context) => CheckBoxTileCubit(),
      child: BlocBuilder<CheckBoxTileCubit, Map<String, bool>>(
        builder: (context, state) {
          final bool currentValue = state[uniqueKey] ?? initialValue ?? false;

          return CheckboxListTile(
            visualDensity: const VisualDensity(
              vertical: VisualDensity.minimumDensity,
              horizontal: VisualDensity.minimumDensity,
            ),
            contentPadding: contentPadding ?? EdgeInsetsDirectional.zero,
            value: currentValue,
            title: BodyTitle(
              overflow: TextOverflow.visible,
              text: title,
              fontSize: AppFontSize.s15,
            ),
            onChanged: (bool? value) {
              if (value != null) {
                context.read<CheckBoxTileCubit>().toggleCheckboxTile(uniqueKey, value);
                onChanged?.call(value);
              }
            },
            secondary: secondary,
            activeColor: activeColor ?? AppColors.primary,
            checkColor: checkColor,
          );
        },
      ),
    );
  }
}
