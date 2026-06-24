import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/screens/notifications/widgets/notifications_home_indicator.dart';
import 'package:wlcd/presentation/screens/more/widgets/learning_interests_widget.dart';
import 'package:wlcd/presentation/screens/private_tutors/private_tutor_categories_screen.dart';
import 'package:wlcd/core/resources/app_fonts.dart';
import 'package:wlcd/presentation/screens/profile/widgets/profile_menu_data.dart';
import 'package:wlcd/presentation/screens/profile/widgets/profile_menu_section.dart';
import 'package:wlcd/presentation/widgets/custom_app_bar.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      appBar: const CustomAppBar(title: 'المزيد', centerTitle: true),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: AppWidth.w428),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    AppPaddingWidth.p17,
                    AppPaddingHeight.p35,
                    AppPaddingWidth.p17,
                    AppPaddingHeight.p90,
                  ),
                  child: const Column(
                    children: [
                      LearningInterestsWidget(),
                      SizedBox(height: 16),
                      _PrivateTutorEntryCard(),
                      SizedBox(height: 20),
                      ProfileMenuSection(items: profileAccountItems),
                      // ProfileMenuSection(items: profileBenefitsItems),
                      ProfileMenuSection(items: profileSupportItems),
                      ProfileMenuSection(items: profileSettingsItems),
                    ],
                  ),
                ),
              ),
              const NotificationsHomeIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PrivateTutorEntryCard extends StatelessWidget {
  const _PrivateTutorEntryCard();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const PrivateTutorCategoriesScreen()),
      ),
      child: Ink(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primary, Color(0xFF3654D4)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [BoxShadow(color: Color(0x241F275D), blurRadius: 22, offset: Offset(0, 12))],
        ),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(color: AppColors.white.withOpacity(.16), borderRadius: BorderRadius.circular(18)),
              child: const Icon(Icons.school_rounded, color: AppColors.white, size: 30),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'حجز درس خصوصي',
                    style: TextStyle(
                      fontFamily: AppFontFamily.rubik,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'اختر المادة والمدرس والتاريخ المناسب لك',
                    style: TextStyle(
                      fontFamily: AppFontFamily.rubik,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFE6EAFF),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.white, size: 28),
          ],
        ),
      ),
    );
  }
}
