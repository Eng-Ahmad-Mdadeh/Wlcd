import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/cubit/choice_chip/choice_chip_cubit.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

import '../../core/routes/app_routes_imports.dart';

class CustomChoiceChipGradient extends StatelessWidget {
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

  const CustomChoiceChipGradient({
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
                  final borderRadius = BorderRadius.circular(AppRadius.r7);

                  return Padding(
                    padding: EdgeInsets.only(right: spacing ?? AppWidth.w10),
                    child: Material(
                      color: Colors.transparent,
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: borderRadius,
                          gradient: isSelected
                              ? const LinearGradient(
                                  begin: AlignmentDirectional.topEnd,
                                  end: AlignmentDirectional.bottomStart,
                                  colors: [
                                    AppColors.primary,
                                    Color(0xFF1E8770),
                                  ],
                                )
                              : null,
                          color: isSelected ? null : (backgroundColor ?? AppColors.grey.withAlpha(50)),
                        ),
                        child: InkWell(
                          borderRadius: borderRadius,
                          onTap: () {
                            if (useInternalCubit) {
                              context.read<ChoiceChipCubit>().selectItem(item.value);
                            }
                            onSelected?.call(item.value);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppPaddingWidth.p13,
                              vertical: AppPaddingHeight.p7,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              spacing: AppWidth.w3,
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  size: AppSize.s18,
                                  color: isSelected
                                      ? (selectedTextColor ?? AppColors.white)
                                      : (textColor ?? AppColors.black),
                                ),
                                SectionTitle(
                                  text: item.label,
                                  fontSize: AppFontSize.s13,
                                  color: isSelected
                                      ? (selectedTextColor ?? AppColors.white)
                                      : (textColor ?? AppColors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
