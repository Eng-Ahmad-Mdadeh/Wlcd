
import 'package:hive_flutter/adapters.dart';

import 'locator/locator.dart';

class AppServices {
  static Future<void> init() async {
    // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    // await FirebaseNotificationsHandler().init();

    if (!Hive.isAdapterRegistered(0)) {
      await Hive.initFlutter();
    }
    configureDependencies();
  }
}
