import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/cubit/choice_chip/choice_chip_cubit.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';

import '../../core/routes/app_routes_imports.dart';

class CustomChoiceChip extends StatelessWidget {
  final List<ChoiceChipItem> items;
  final String? initialValue;
  final ValueChanged<String>? onSelected;
  final String? title;
  final Color? selectedColor;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? selectedTextColor;
  final double? spacing;
  final double? runSpacing;
  final Axis direction;
  final WrapAlignment alignment;
  final bool useInternalCubit;

  const CustomChoiceChip({
    super.key,
    required this.items,
    this.initialValue,
    this.onSelected,
    this.title,
    this.selectedColor,
    this.backgroundColor,
    this.textColor,
    this.selectedTextColor,
    this.spacing,
    this.runSpacing,
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.start,
    this.useInternalCubit = true,
  });

  @override
  Widget build(BuildContext context) {
    if (useInternalCubit) {
      return BlocProvider<ChoiceChipCubit>(
        create: (context) => ChoiceChipCubit(
          initialValue: initialValue,
          items: items,
        ),
        child: _ChoiceChipContent(

          title: title,
          selectedColor: selectedColor,
          backgroundColor: backgroundColor,
          textColor: textColor,
          selectedTextColor: selectedTextColor,
          spacing: spacing,
          runSpacing: runSpacing,
          direction: direction,
          alignment: alignment,
          onSelected: onSelected,
          useInternalCubit: useInternalCubit,
        ),
      );
    } else {
      return _ChoiceChipContent(
        title: title,
        selectedColor: selectedColor,
        backgroundColor: backgroundColor,
        textColor: textColor,
        selectedTextColor: selectedTextColor,
        spacing: spacing,
        runSpacing: runSpacing,
        direction: direction,
        alignment: alignment,
        onSelected: onSelected,
        useInternalCubit: useInternalCubit,
      );
    }
  }
}

class _ChoiceChipContent extends StatelessWidget {
  final String? title;
  final Color? selectedColor;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? selectedTextColor;
  final double? spacing;
  final double? runSpacing;
  final Axis direction;
  final WrapAlignment alignment;
  final ValueChanged<String>? onSelected;
  final bool useInternalCubit;

  const _ChoiceChipContent({
    this.title,
    this.selectedColor,
    this.backgroundColor,
    this.textColor,
    this.selectedTextColor,
    this.spacing,
    this.runSpacing,
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.start,
    this.onSelected,
    required this.useInternalCubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChoiceChipCubit, ChoiceChipState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              BodyTitle(
                text: title!,
                color: AppColors.primary,
                fontSize: AppFontSize.s14,
              ),
              SizedBox(height: AppHeight.h10),
            ],
            SingleChildScrollView(
              padding: EdgeInsetsDirectional.only(
                end: AppPaddingHeight.p10,
                start: AppPaddingHeight.p10,
              ),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: state.items.map((item) {
                  final bool isSelected = state.selectedValue == item.value;
                  return Padding(
                    padding: EdgeInsets.only(right: spacing ?? AppWidth.w10),
                    child: ChoiceChip(
                      side: BorderSide.none,
                      color: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
                        return isSelected ? AppColors.primary : AppColors.searchColor;

                      }),

                      label: BodyTitle(
                        text: item.label,
                        fontSize: AppFontSize.s13,
                        color: isSelected ? (selectedTextColor ?? AppColors.white) : (textColor ?? AppColors.black),
                      ),
                      checkmarkColor: selectedTextColor ?? AppColors.white,
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          if (useInternalCubit) {
                            context.read<ChoiceChipCubit>().selectItem(item.value);
                          }
                          onSelected?.call(item.value);
                        }
                      },

                      selectedColor: selectedColor ?? AppColors.primary,
                      backgroundColor: backgroundColor ?? AppColors.grey.withAlpha(50),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
