import 'package:flutter/material.dart';

class ProfileMenuItemData {
  const ProfileMenuItemData({
    required this.title,
    required this.icon,
    this.showTrailingArrow = true,
    this.isDarkMode = false,
  });

  final String title;
  final IconData icon;
  final bool showTrailingArrow;
  final bool isDarkMode;
}

const List<ProfileMenuItemData> profileAccountItems = [
  ProfileMenuItemData(title: 'Personal Details', icon: Icons.person_outline),
  ProfileMenuItemData(title: 'Preference Video', icon: Icons.videocam_outlined),
  ProfileMenuItemData(title: 'Your Download', icon: Icons.file_download_outlined),
  ProfileMenuItemData(
    title: 'Dark Mode',
    icon: Icons.dark_mode_outlined,
    showTrailingArrow: false,
    isDarkMode: true,
  ),
];

const List<ProfileMenuItemData> profileBenefitsItems = [
  ProfileMenuItemData(title: 'Referral Code', icon: Icons.card_giftcard_outlined),
  ProfileMenuItemData(title: 'Learning Reminder', icon: Icons.calendar_today_outlined),
  ProfileMenuItemData(title: 'Voucher Code', icon: Icons.confirmation_number_outlined),
];

const List<ProfileMenuItemData> profileSupportItems = [
  ProfileMenuItemData(title: 'Invester Academy', icon: Icons.description_outlined),
  ProfileMenuItemData(title: 'FAQs', icon: Icons.help_outline),
  ProfileMenuItemData(title: 'Help Center', icon: Icons.headset_mic_outlined),
];

const List<ProfileMenuItemData> profileSettingsItems = [
  ProfileMenuItemData(title: 'Language', icon: Icons.language_outlined),
  ProfileMenuItemData(title: 'Privacy', icon: Icons.privacy_tip_outlined),
];
