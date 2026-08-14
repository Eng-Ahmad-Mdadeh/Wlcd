import '../helper/network_helper.dart';
import 'locator/locator.dart';

class AppServices {
  static Future<void> init() async {
    // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    // await FirebaseNotificationsHandler().init();

    configureDependencies();
    await NetworkHelper().initializeApplicationHeaders();
  }
}
