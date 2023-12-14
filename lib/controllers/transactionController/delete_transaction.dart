part of 'transaction_controller.dart';

Future<void> implementDeleteTransaction({
  required int id,
}) async {
  try {
    loadingDialog(msg: "Deletando transação...");

    final transactionBox = Hive.box('transactions');
    await transactionBox.delete(id);
    Get.find<TransactionController>().refresh();
    Get.back();
    Get.back();
    Get.back();

    Get.showSnackbar(Ui.successSnackBar(message: "Transação excluída!"));
  } catch (e) {
    alertDialog(title: "Algo deu errado!\nTente novamente.");
  }
}
