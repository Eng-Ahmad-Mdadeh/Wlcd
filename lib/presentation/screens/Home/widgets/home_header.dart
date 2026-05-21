import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/core/extension/localization_extension.dart';
import 'package:wlcd/core/routes/app_routes.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: context.loc.home_welcome_user,
            style: TextStyle(
              color: AppColors.white,
              fontSize: AppFontSize.s16,
              fontWeight: AppFontWeight.extraBold,
              fontFamily: AppFontFamily.rubik,
            ),
            children: const [TextSpan(text: '👋')],
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
    );
  }
}

class HeaderActions extends StatelessWidget {
  const HeaderActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const HeaderIconButton(icon: Icons.search, semanticLabel: 'search'),
        SizedBox(width: AppWidth.w8),
        const HeaderIconButton(icon: Icons.notifications_none_outlined, semanticLabel: 'Notifications', showDot: true),
      ],
    );
  }
}

class HeaderIconButton extends StatelessWidget {
  const HeaderIconButton({super.key, required this.icon, required this.semanticLabel, this.showDot = false});

  final IconData icon;
  final String semanticLabel;
  final bool showDot;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
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
