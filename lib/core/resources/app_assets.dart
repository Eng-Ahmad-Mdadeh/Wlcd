class AppAssets {
  //#region Path
  static String imagePath = 'assets/images';
  static String iconPath = 'assets/icons';
  static String imageTmpPath = 'assets/images/tmp';
  static String imageHorsePath = 'assets/images/horse';
  static String imageCamelPath = 'assets/images/camel';
  static String jsonPath = 'assets/json';
  static String soundPath = 'assets/sounds';

  //#endregion

  //#region Logo
  static String fullLogo = '$imagePath/full_logo.png';
  static String logo = '$imagePath/logo.svg';

  //#endregion

  //#region Profile
  static String profile = '$imagePath/profile.png';

  //#endregion
  static String defaultImage = '$imagePath/default.jpeg';
  static String buildingImage = '$imagePath/building.jpg';

  //#endregion

  //#region Sounds
  static String bidHoursSound = '$soundPath/bid.m4a';
  static String bidCamlSound = '$soundPath/playback.m4a';
  static String auctionAlerts = '$soundPath/auction_alerts.m4a';

  //#endregion

  //#region No Result
  static String noResult = '$jsonPath/no_result.json';
  static String logoJson = '$jsonPath/logo_animation.json';
  static String errorJson = '$jsonPath/error.json';
  //#endregion
}
