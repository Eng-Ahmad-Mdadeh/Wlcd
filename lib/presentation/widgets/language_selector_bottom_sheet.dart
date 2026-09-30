import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/extension/localization_extension.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/cubit/language/language_cubit.dart';

Future<void> showLanguageSelector(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    useSafeArea: true,
    showDragHandle: true,
    backgroundColor: AppColors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.r24)),
    ),
    builder: (_) => BlocProvider.value(
      value: context.read<LanguageCubit>(),
      child: const _LanguageSelectorContent(),
    ),
  );
}

class _LanguageSelectorContent extends StatelessWidget {
  const _LanguageSelectorContent();

  @override
  Widget build(BuildContext context) {
    final selectedCode = context.watch<LanguageCubit>().state.languageCode;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppPaddingWidth.p20,
        0,
        AppPaddingWidth.p20,
        AppPaddingHeight.p24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.loc.choose_language,
            style: TextStyle(
              color: AppColors.text,
              fontSize: AppFontSize.s20,
              fontWeight: AppFontWeight.bold,
            ),
          ),
          SizedBox(height: AppHeight.h8),
          _LanguageOption(
            languageCode: 'ar',
            label: context.loc.language_arabic,
            flag: '🇸🇦',
            selected: selectedCode == 'ar',
          ),
          SizedBox(height: AppHeight.h8),
          _LanguageOption(
            languageCode: 'en',
            label: context.loc.language_english,
            flag: '🇬🇧',
            selected: selectedCode == 'en',
          ),
        ],
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.languageCode,
    required this.label,
    required this.flag,
    required this.selected,
  });

  final String languageCode;
  final String label;
  final String flag;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: selected,
      button: true,
      label: label,
      child: Material(
        color: selected ? AppColors.lightBlue : AppColors.backGround,
        borderRadius: BorderRadius.circular(AppRadius.r13),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.r13),
          onTap: () async {
            await context.read<LanguageCubit>().setLocale(Locale(languageCode));
            if (context.mounted) Navigator.of(context).pop();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppPaddingWidth.p16,
              vertical: AppPaddingHeight.p14,
            ),
            child: Row(
              children: [
                Text(flag, style: TextStyle(fontSize: AppFontSize.s24)),
                SizedBox(width: AppWidth.w12),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: AppColors.text,
                      fontSize: AppFontSize.s16,
                      fontWeight: selected ? AppFontWeight.bold : AppFontWeight.medium,
                    ),
                  ),
                ),
                if (selected)
                  Icon(Icons.check_circle_rounded, color: AppColors.accent, size: AppSize.s22),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
