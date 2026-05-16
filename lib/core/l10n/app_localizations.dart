import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'Platform'**
  String get app_name;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Return to Home'**
  String get home;

  /// No description provided for @horses_platform.
  ///
  /// In en, this message translates to:
  /// **'Horses Platform'**
  String get horses_platform;

  /// No description provided for @camels_platform.
  ///
  /// In en, this message translates to:
  /// **'Camels Platform'**
  String get camels_platform;

  /// No description provided for @mass_auctions.
  ///
  /// In en, this message translates to:
  /// **'Mass Auctions'**
  String get mass_auctions;

  /// No description provided for @mass_horse_auctions.
  ///
  /// In en, this message translates to:
  /// **'Mass Horse Auctions'**
  String get mass_horse_auctions;

  /// No description provided for @mass_camel_auctions.
  ///
  /// In en, this message translates to:
  /// **'Mass Camel Auctions'**
  String get mass_camel_auctions;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @download_catalog.
  ///
  /// In en, this message translates to:
  /// **'Download Catalog'**
  String get download_catalog;

  /// No description provided for @i_agree_to_the.
  ///
  /// In en, this message translates to:
  /// **'I agree to the'**
  String get i_agree_to_the;

  /// No description provided for @terms_and_conditions.
  ///
  /// In en, this message translates to:
  /// **'terms and conditions'**
  String get terms_and_conditions;

  /// No description provided for @direct_electronic.
  ///
  /// In en, this message translates to:
  /// **'Direct electronic'**
  String get direct_electronic;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @medical_services.
  ///
  /// In en, this message translates to:
  /// **'Medical Services'**
  String get medical_services;

  /// No description provided for @transport_services.
  ///
  /// In en, this message translates to:
  /// **'Transport Services'**
  String get transport_services;

  /// No description provided for @animal_products.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get animal_products;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @contact_us.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contact_us;

  /// No description provided for @offers.
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get offers;

  /// No description provided for @auctions.
  ///
  /// In en, this message translates to:
  /// **'Auctions'**
  String get auctions;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @tap_back_again_to_leave.
  ///
  /// In en, this message translates to:
  /// **'Tap back again to leave'**
  String get tap_back_again_to_leave;

  /// No description provided for @choose_language.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get choose_language;

  /// No description provided for @language_arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get language_arabic;

  /// No description provided for @language_english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language_english;

  /// No description provided for @logout_success.
  ///
  /// In en, this message translates to:
  /// **' Logged out successfully'**
  String get logout_success;

  /// No description provided for @logout_failed.
  ///
  /// In en, this message translates to:
  /// **' Logout failed on server'**
  String get logout_failed;

  /// No description provided for @logout_error.
  ///
  /// In en, this message translates to:
  /// **'An error occurred during logout'**
  String get logout_error;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Server Error'**
  String get title;

  /// No description provided for @stay_logged_in.
  ///
  /// In en, this message translates to:
  /// **'Stay logged in'**
  String get stay_logged_in;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @continue_as_guest.
  ///
  /// In en, this message translates to:
  /// **'Continue as guest'**
  String get continue_as_guest;

  /// No description provided for @enter_valid_phone.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Please enter a valid phone number.'**
  String get enter_valid_phone;

  /// No description provided for @code_sent.
  ///
  /// In en, this message translates to:
  /// **'✅ Verification code sent to your number.'**
  String get code_sent;

  /// No description provided for @send_failed.
  ///
  /// In en, this message translates to:
  /// **'❌ Failed to send code, please try again.'**
  String get send_failed;

  /// No description provided for @login_success.
  ///
  /// In en, this message translates to:
  /// **'🎉 Logged in successfully'**
  String get login_success;

  /// No description provided for @invalid_code.
  ///
  /// In en, this message translates to:
  /// **'Invalid verification code, please try again.'**
  String get invalid_code;

  /// No description provided for @verify_failed.
  ///
  /// In en, this message translates to:
  /// **'❌ Verification failed.'**
  String get verify_failed;

  /// No description provided for @resent_info.
  ///
  /// In en, this message translates to:
  /// **'🔁 Code resent (test only).'**
  String get resent_info;

  /// No description provided for @sending.
  ///
  /// In en, this message translates to:
  /// **'Sending'**
  String get sending;

  /// No description provided for @verifying.
  ///
  /// In en, this message translates to:
  /// **'Verifying'**
  String get verifying;

  /// No description provided for @fill_all_fields.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Please fill in all fields.'**
  String get fill_all_fields;

  /// No description provided for @profile_saved.
  ///
  /// In en, this message translates to:
  /// **'✅ Data saved successfully!'**
  String get profile_saved;

  /// No description provided for @profile_save_error.
  ///
  /// In en, this message translates to:
  /// **'❌ Failed to save data, please try again.'**
  String get profile_save_error;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving'**
  String get saving;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone_number;

  /// No description provided for @enter_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Enter Phone Number'**
  String get enter_phone_number;

  /// No description provided for @login_required_title.
  ///
  /// In en, this message translates to:
  /// **'Login Required'**
  String get login_required_title;

  /// No description provided for @login_required_message.
  ///
  /// In en, this message translates to:
  /// **'To access this page, you must be logged in. Please sign in with your account to continue.'**
  String get login_required_message;

  /// No description provided for @login_now.
  ///
  /// In en, this message translates to:
  /// **'Login Now'**
  String get login_now;

  /// No description provided for @back_home.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get back_home;

  /// No description provided for @login_required_alt.
  ///
  /// In en, this message translates to:
  /// **'Login icon'**
  String get login_required_alt;

  /// No description provided for @otp_sent_to.
  ///
  /// In en, this message translates to:
  /// **'We sent a verification code to'**
  String get otp_sent_to;

  /// No description provided for @otp_resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get otp_resend;
  /// No description provided for @login_welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Hi! Welcome Back'**
  String get login_welcome_back;

  /// No description provided for @login_welcome_subtitle.
  ///
  /// In en, this message translates to:
  /// **'We happy to see you again! to use your\naccount, you should sign in first.'**
  String get login_welcome_subtitle;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @your_email.
  ///
  /// In en, this message translates to:
  /// **'Your email'**
  String get your_email;

  /// No description provided for @your_password.
  ///
  /// In en, this message translates to:
  /// **'Your password'**
  String get your_password;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgot_password;

  /// No description provided for @sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get sign_in;

  /// No description provided for @or_with_email.
  ///
  /// In en, this message translates to:
  /// **'Or with email'**
  String get or_with_email;

  /// No description provided for @apple.
  ///
  /// In en, this message translates to:
  /// **'Apple'**
  String get apple;

  /// No description provided for @google.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get google;

  /// No description provided for @dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account? '**
  String get dont_have_account;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get sign_up;

  /// No description provided for @enter_email_validation.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get enter_email_validation;

  /// No description provided for @invalid_email_validation.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get invalid_email_validation;

  /// No description provided for @enter_password_validation.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get enter_password_validation;

  /// No description provided for @short_password_validation.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get short_password_validation;

}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
