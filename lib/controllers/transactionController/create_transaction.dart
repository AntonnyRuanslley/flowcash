part of 'transaction_controller.dart';

Future<void> implementCreateTransaction({
  required BuildContext context,
  required Map<String, dynamic> newTransaction,
  required Function() onRefresh,
}) async {
  loadingDialog(msg:  "Criando transação...");
  final transactionBox = Hive.box('transactions');
  await transactionBox.add(newTransaction);
  onRefresh();
  Navigator.of(context).pop();
  Navigator.of(context).pop();
  ScaffoldMessenger.of(context).showSnackBar(transactionAdded);
}
