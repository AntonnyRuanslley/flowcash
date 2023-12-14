part of 'transaction_controller.dart';

Future<void> implementCreateTransaction({
  required Map<String, dynamic> newTransaction,
}) async {
  loadingDialog(msg: "Criando transação...");

  final transactionBox = Hive.box('transactions');
  await transactionBox.add(newTransaction);
  Get.find<TransactionController>().refresh();
  Get.back();
  Get.back();

  Get.showSnackbar(Ui.successSnackBar(message: "Nova transação criada!"));
}
