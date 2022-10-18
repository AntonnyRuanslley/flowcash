part of 'transaction_controller.dart';

Future<void> implementUpdateTransaction({
  required BuildContext context,
  required int transactionId,
  required Map<String, dynamic> updateTransaction,
  required Function() onRefresh,
}) async {
  final transactionsBox = Hive.box('transactions');

  await transactionsBox.put(transactionId, updateTransaction);
  onRefresh();
  Navigator.of(context).pop();
  Navigator.of(context).pop();
  ScaffoldMessenger.of(context).showSnackBar(transactionEditted);
}
