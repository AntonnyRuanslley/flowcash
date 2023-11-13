import 'package:get/get.dart';

import '../controllers/transactionController/transaction_controller.dart';

class TransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionController>(
      () => TransactionController(),
    );
  }
}
