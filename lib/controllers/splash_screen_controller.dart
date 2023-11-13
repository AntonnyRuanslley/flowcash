import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../services/settings_service.dart';
import '../routes/routes_names.dart';

class SplashScreenController extends GetxController {
  final settingsService = Get.find<SettingsService>();

  void initializeApp() async {
    if (settingsService.hasChoice) {
      Get.offNamed(RoutesNames.selectionPage);
    } else {
      if (settingsService.isOnline) {
        final connectivityResult = await Connectivity().checkConnectivity();
        if (connectivityResult == ConnectivityResult.none) {
          return;
        }
        settingsService.onLogin().then((value) {
          if (value) {
            Get.offAllNamed(RoutesNames.loginPage);
          } else {
            settingsService.getUser().then((value) {
              if (value) {
                Get.offAllNamed(RoutesNames.homePage);
              } else {
                Get.offAllNamed(RoutesNames.transactionsListPage);
              }
            });
          }
        });
      } else {
        Get.offAllNamed(RoutesNames.transactionsListLocalPage);
      }
    }
  }
}
