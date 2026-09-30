import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/core/extension/localization_extension.dart';
import 'package:wlcd/core/routes/app_routes.dart';
import 'package:wlcd/presentation/bloc/profile/get_profile/get_profile_bloc.dart';
import 'package:wlcd/presentation/cubit/language/language_cubit.dart';
import 'package:wlcd/presentation/widgets/custom_text_from_field.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.searchController, required this.onSearchChanged});

  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppHeight.h200,
      width: AppWidth.w428,
      color: AppColors.primary,
      child: Padding(
        padding: EdgeInsets.fromLTRB(AppPaddingWidth.p23, 0, AppPaddingWidth.p23, AppPaddingHeight.p23),
        child: Column(
          children: [
            SizedBox(height: AppHeight.h15),
            const HomeHeaderTopRow(),
            SizedBox(height: AppHeight.h24),
            HomeSearchField(controller: searchController, onChanged: onSearchChanged),
          ],
        ),
      ),
    );
  }
}

class HomeHeaderTopRow extends StatelessWidget {
  const HomeHeaderTopRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(child: WelcomeText()),
        SizedBox(width: AppWidth.w12),
        const HeaderActions(),
      ],
    );
  }
}

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProfileBloc, IGetProfileState>(
      buildWhen: (previous, current) => current is GetProfileLoaded || current is GetProfileFailed,
      builder: (context, state) {
        final displayName = state is GetProfileLoaded ? state.profileModel?.data?.displayName : null;

        return InkWell(
          onTap: () => ProfileRoute().push(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: '${context.loc.home_welcome_user}${displayName ?? ''}',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: AppFontSize.s16,
                    fontWeight: AppFontWeight.extraBold,
                    fontFamily: AppFontFamily.rubik,
                  ),
                  children: const [TextSpan(text: ' 👋')],
                ),
              ),
              SizedBox(height: AppHeight.h7),
              BodyTitle(
                text: context.loc.home_upgrade_skill,
                color: AppColors.white.withOpacity(.72),
                fontSize: AppFontSize.s12,
                fontWeight: AppFontWeight.medium,
              ),
            ],
          ),
        );
      },
    );
  }
}

class HeaderActions extends StatelessWidget {
  const HeaderActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        HeaderIconButton(
          icon: Icons.language_rounded,
          semanticLabel: context.loc.language_button_label,
          onTap: () => _showLanguageSelector(context),
        ),
        SizedBox(width: AppWidth.w8),
        HeaderIconButton(
          icon: Icons.notifications_none_outlined,
          semanticLabel: context.loc.notifications,
          showDot: true,
          onTap: () => NotificationsRoute().push(context),
        ),
      ],
    );
  }

  Future<void> _showLanguageSelector(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      // Home lives inside the StatefulShellRoute's nested navigator. Presenting
      // on the root navigator keeps the modal barrier and sheet above the shell
      // scaffold, including its persistent bottom navigation bar.
      useRootNavigator: true,
      useSafeArea: true,
      showDragHandle: true,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.r20)),
      ),
      builder: (sheetContext) => const _LanguageSelectorSheet(),
    );
  }
}

class _LanguageSelectorSheet extends StatelessWidget {
  const _LanguageSelectorSheet();

  @override
  Widget build(BuildContext context) {
    final currentCode = context.watch<LanguageCubit>().state.languageCode;
    final options = <({String code, String label})>[
      (code: 'ar', label: context.loc.language_arabic),
      (code: 'en', label: context.loc.language_english),
    ];

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppPaddingWidth.p23,
        0,
        AppPaddingWidth.p23,
        AppPaddingHeight.p23,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.loc.language_selector_title,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: AppFontSize.s20,
              fontWeight: AppFontWeight.bold,
            ),
          ),
          SizedBox(height: AppHeight.h6),
          Text(
            context.loc.language_selector_subtitle,
            style: TextStyle(
              color: AppColors.black.withOpacity(.6),
              fontSize: AppFontSize.s13,
            ),
          ),
          SizedBox(height: AppHeight.h18),
          ...options.map(
            (option) => Padding(
              padding: EdgeInsets.only(bottom: AppPaddingHeight.p10),
              child: _LanguageOption(
                label: option.label,
                languageCode: option.code,
                selected: currentCode == option.code,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.label,
    required this.languageCode,
    required this.selected,
  });

  final String label;
  final String languageCode;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.r15),
        onTap: () async {
          if (selected) return;
          await context.read<LanguageCubit>().setLocale(Locale(languageCode));
          if (context.mounted) Navigator.of(context).pop();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.symmetric(
            horizontal: AppPaddingWidth.p15,
            vertical: AppPaddingHeight.p15,
          ),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary.withOpacity(.08) : AppColors.backGround,
            borderRadius: BorderRadius.circular(AppRadius.r15),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.black.withOpacity(.08),
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: AppSize.s18,
                backgroundColor: AppColors.primary.withOpacity(.1),
                child: Text(
                  languageCode.toUpperCase(),
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: AppFontSize.s12,
                    fontWeight: AppFontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: AppWidth.w12),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: AppFontSize.s16,
                    fontWeight: AppFontWeight.semiBold,
                  ),
                ),
              ),
              if (selected)
                Icon(Icons.check_circle_rounded, color: AppColors.primary, size: AppSize.s22),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderIconButton extends StatelessWidget {
  const HeaderIconButton({
    super.key,
    required this.icon,
    required this.semanticLabel,
    this.showDot = false,
    this.onTap,
  });

  final IconData icon;
  final String semanticLabel;
  final bool showDot;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.r15),
        splashColor: AppColors.none,
        highlightColor: AppColors.none,
        child: Container(
          width: AppWidth.w37,
          height: AppHeight.h37,
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(.08),
            borderRadius: BorderRadius.circular(AppRadius.r15),
            border: Border.all(color: AppColors.white.withOpacity(.28)),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(icon, color: AppColors.white, size: AppSize.s22),
              if (showDot)
                PositionedDirectional(
                  top: AppHeight.h12,
                  end: AppWidth.w10,
                  child: Container(
                    width: AppWidth.w8,
                    height: AppHeight.h8,
                    decoration: BoxDecoration(
                      color: AppColors.notificationDot,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: AppWidth.w1),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeSearchField extends StatelessWidget {
  const HomeSearchField({super.key, required this.controller, required this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppHeight.h52,
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(.06),
        borderRadius: BorderRadius.circular(AppRadius.r7),
        border: Border.all(color: AppColors.white.withOpacity(.14)),
      ),
      padding: EdgeInsetsDirectional.symmetric(horizontal: AppPaddingWidth.p15),
      child: Row(
        children: [
          Icon(Iconsax.search_normal_outline, color: AppColors.white.withOpacity(.72), size: AppSize.s18),
          SizedBox(width: AppWidth.w11),
          Expanded(
            child: CustomTextFromField(
              onTap: () => SearchRoute().push(context),
              controller: controller,
              onChanged: onChanged,
              cursorColor: AppColors.white,
              readOnly: true,
              hintText: context.loc.home_search_hint,
              color: AppColors.none,
              fontSize: AppFontSize.s13,
            ),
          ),
        ],
      ),
    );
  }
}
