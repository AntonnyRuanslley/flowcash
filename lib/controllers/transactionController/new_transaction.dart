part of 'transaction_controller.dart';

Future<void> implementNewTransaction({
  required BuildContext context,
  required Map<String, dynamic> newTransaction,
  required Function() onRefresh,
}) async {
  final transactionBox = Hive.box('transactions');

  await transactionBox.add(newTransaction);
  onRefresh();
  Navigator.of(context).pop();
  ScaffoldMessenger.of(context).showSnackBar(transactionAdded);
}
