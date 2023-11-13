import 'package:get/get.dart';

import '../services/settings_service.dart';
import '../routes/routes_names.dart';

class SelectionController extends GetxController {
  Future<void> onChoice({required bool isOnline}) async {
    await Get.find<SettingsService>()
        .postChoice(choice: isOnline)
        .then((value) {
      Get.offNamed(RoutesNames.splashScreenPage);
    });
  }
}
