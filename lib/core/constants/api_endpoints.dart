class ApiEndpoints {
  const ApiEndpoints._();

  //#region Base Url
  static const String baseUrl = 'https://wlcd.mubashar.tr';
  //#endregion


  //#region Auth
  static const String auth = '/auth';
  static const String registerWithEmail = '/register/email';
  static const String registerWithPhone = '/register/phone';
  static const String verifyEmail = '/verify/email';
  static const String login = '/login';
  static const String checkCode = '/check-code';
//#endregion
}
