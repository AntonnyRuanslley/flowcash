import 'package:get/get.dart';

import '../controllers/selection_controller.dart';

class SelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectionController>(
      () => SelectionController(),
    );
  }
}
