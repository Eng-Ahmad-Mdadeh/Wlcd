import 'package:flutter/material.dart';
import 'package:wlcd/core/extension/localization_extension.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/core/routes/app_routes.dart';
import 'package:wlcd/presentation/screens/profile/widgets/profile_menu_data.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';

class ProfileMenuTile extends StatelessWidget {
  const ProfileMenuTile({super.key, required this.item, required this.showDivider});

  final ProfileMenuItemData item;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _handleTap(context),
      splashColor: AppColors.none,
      highlightColor: AppColors.none,
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: AppPaddingWidth.p16),
        child: Column(
          children: [
            SizedBox(
              height: AppHeight.h62,
              child: Row(
                children: [
                  Icon(item.icon, color: AppColors.profileIcon, size: AppSize.s25),
                  SizedBox(width: AppWidth.w20),
                  Expanded(
                    child: BodyTitle(text: _title(context), color: AppColors.profileText, maxLines: 1),
                  ),
                  Icon(Icons.chevron_right, color: AppColors.profileChevron, size: AppSize.s25),
                  SizedBox(width: AppWidth.w16),
                ],
              ),
            ),
            if (showDivider)
              Divider(height: AppHeight.h1, thickness: AppHeight.h1, color: AppColors.notificationBorder),
          ],
        ),
      ),
    );
  }

  String _title(BuildContext context) {
    return switch (item.action) {
      ProfileMenuAction.orderHistory => context.loc.order_history,
      ProfileMenuAction.progressHistory => context.loc.progress_history,
      ProfileMenuAction.personalInformation => context.loc.personal_information,
      ProfileMenuAction.categorySelection => context.loc.book_lesson,
      // ProfileMenuAction.teachers => 'المدرسون',
      ProfileMenuAction.privacyPolicy => context.loc.privacy_policy,
      ProfileMenuAction.faqs => context.loc.faqs,
      ProfileMenuAction.termsAndConditions => context.loc.terms_and_conditions_title,
      null => switch (item.title) {
        'Invester Academy' => context.loc.investor_academy,
        'Help Center' => context.loc.help_center,
        'Language' => context.loc.language_selector_title,
        _ => item.title,
      },
    };
  }

  void _handleTap(BuildContext context) {
    switch (item.action) {
      case ProfileMenuAction.orderHistory:
        OrderHistoryRoute().push(context);
      case ProfileMenuAction.progressHistory:
        ProgressHistoryRoute().push(context);
      case ProfileMenuAction.personalInformation:
        PersonalInformationRoute().push(context);
      case ProfileMenuAction.categorySelection:
        CategorySelectionRoute().push(context);
      // case ProfileMenuAction.teachers:
      //   TeachersRoute().push(context);
      case ProfileMenuAction.privacyPolicy:
        PrivacyPolicyRoute().push(context);
      case ProfileMenuAction.faqs:
        FaqsRoute().push(context);
      case ProfileMenuAction.termsAndConditions:
        TermsAndConditionsRoute().push(context);
      case null:
        break;

    }
  }
}
