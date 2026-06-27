import 'package:flutter/material.dart';

enum ProfileMenuAction {
  personalInformation,
  categorySelection,
  teachers,
  orderHistory,
  progressHistory,
  privacyPolicy,
  faqs,
  termsAndConditions,
}

class ProfileMenuItemData {
  const ProfileMenuItemData({required this.title, required this.icon, this.showTrailingArrow = true, this.action});

  final String title;
  final IconData icon;
  final bool showTrailingArrow;
  final ProfileMenuAction? action;
}

const List<ProfileMenuItemData> profileAccountItems = [
  ProfileMenuItemData(
    title: 'Personal Details',
    icon: Icons.person_outline,
    action: ProfileMenuAction.personalInformation,
  ),
  // ProfileMenuItemData(title: 'Preference Video', icon: Icons.videocam_outlined),
  // ProfileMenuItemData(title: 'Your Download', icon: Icons.file_download_outlined),
  ProfileMenuItemData(
    title: 'Order History',
    icon: Icons.receipt_long_outlined,
    action: ProfileMenuAction.orderHistory,
  ),
  ProfileMenuItemData(
    title: 'Progress History',
    icon: Icons.trending_up_outlined,
    action: ProfileMenuAction.progressHistory,
  ),
  ProfileMenuItemData(
    title: 'التصنيفات التعليمية',
    icon: Icons.category_outlined,
    action: ProfileMenuAction.categorySelection,
  ),
  ProfileMenuItemData(
    title: 'المدرسون',
    icon: Icons.school_outlined,
    action: ProfileMenuAction.teachers,
  ),
];

const List<ProfileMenuItemData> profileBenefitsItems = [
  ProfileMenuItemData(title: 'Referral Code', icon: Icons.card_giftcard_outlined),
  ProfileMenuItemData(title: 'Learning Reminder', icon: Icons.calendar_today_outlined),
  ProfileMenuItemData(title: 'Voucher Code', icon: Icons.confirmation_number_outlined),
];

const List<ProfileMenuItemData> profileSupportItems = [
  ProfileMenuItemData(title: 'Invester Academy', icon: Icons.description_outlined),
  ProfileMenuItemData(title: 'FAQs', icon: Icons.help_outline, action: ProfileMenuAction.faqs),
  ProfileMenuItemData(title: 'Help Center', icon: Icons.headset_mic_outlined),
];

const List<ProfileMenuItemData> profileSettingsItems = [
  ProfileMenuItemData(title: 'Language', icon: Icons.language_outlined),
  ProfileMenuItemData(title: 'Privacy', icon: Icons.privacy_tip_outlined, action: ProfileMenuAction.privacyPolicy),
  ProfileMenuItemData(
    title: 'Terms and Conditions',
    icon: Icons.article_outlined,
    action: ProfileMenuAction.termsAndConditions,
  ),
];
