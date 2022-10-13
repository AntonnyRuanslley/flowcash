part of 'transaction_controller.dart';

Future<void> implementDeleteTransaction({
  required BuildContext context,
  required int id,
  required Function() onRefresh,
}) async {
  try {
    final transactionBox = Hive.box('transactions');
    await transactionBox.delete(id);
    onRefresh();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(transactionExcluded);
  } catch (e) {
    alertDialog(context, "Algo deu errado!\nTente novamente.");
  }
}
