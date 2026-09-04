class ApiEndpoints {
  const ApiEndpoints._();

  //#region Base Url
  static const String baseUrl = 'https://wlcd.mubashar.tr/api/v1';
  //#endregion


  //#region Auth
  static const String auth = '/auth';
  static const String registerWithEmail = '/register/email';
  static const String registerWithPhone = '/register/phone';
  static const String verifyEmail = '/verify/email';
  static const String requestPhoneOtp = '/otp/request';
  static const String verifyPhoneOtp = '/otp/verify';
  static const String loginWithPassword = '/login/password';
  static const String requestLoginOtp = '/login/otp/request';
  static const String loginWithOtp = '/login/otp';
  static const String requestPasswordReset = '/password/reset-request';
  static const String resetPassword = '/password/reset';
  static const String logout = '/logout';
  static const String session = '/session';
  static const String login = '/login';
  static const String checkCode = '/check-code';
//#endregion

  //#region Catalog
  static const String catalog = '/catalog';
  static const String categories = '/categories';
  static const String featuredCourses = '/featured';
  static const String recommendedCourses = '/recommendations';
  //#endregion

  //#region Profile
  static const String accounts = '/accounts';
  static const String   profile = '/me';
  static const String completeProfile = '/me/profile/complete';
  static const String updateProfile = '/me/profile';
  static const String learnerAvatar = '/me/profile/avatar';
  static const String addEmailIdentifier = '/me/identifiers/email';
  static const String changeEmail = '/me/identifiers/email/change';
  static const String addPhoneIdentifier = '/me/identifiers/phone';
  static const String changePhone = '/me/identifiers/phone/change';
  //#endregion
}
