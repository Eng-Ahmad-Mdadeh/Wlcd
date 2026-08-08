

import 'locator/locator.dart';

class AppServices {
  static Future<void> init() async {
    // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    // await FirebaseNotificationsHandler().init();


    configureDependencies();
  }
}
