part of 'transaction_controller.dart';

Future<void> implementUpdateTransaction({
  required int transactionId,
  required Map<String, dynamic> updateTransaction,
}) async {
  loadingDialog(msg: "Editando transação...");

  final transactionsBox = Hive.box('transactions');
  await transactionsBox.put(transactionId, updateTransaction);
  Get.find<TransactionController>().refresh();
  Get.back();
  Get.back();
  Get.back();

  Get.showSnackbar(Ui.successSnackBar(message: "Transação editada!"));
}
