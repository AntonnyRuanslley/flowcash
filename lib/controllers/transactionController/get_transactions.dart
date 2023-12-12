part of 'transaction_controller.dart';

Future<void> implementGetTransactions() async {
  if (Get.find<SettingsService>().isOnline) {
    getOfflineTransactions();
  } else {
    getOnlineTransactions();
  }
}

void getOfflineTransactions() {
  final _transactionsBox = Hive.box('transactions');

  final _transactions = _transactionsBox.keys
      .map((key) {
        final data = _transactionsBox.get(key);
        data.addAll({"id": key});
        return Transaction.setTransactionModel(data: data);
      })
      .toList()
      .reversed
      .toList();

  Get.find<TransactionController>().allTransactions.addAll(_transactions);
  Get.find<TransactionController>()
      .dayTransactions
      .addAll(_transactions.reversed.toList());

  Get.find<TransactionController>().dayTransactions.removeWhere((transaction) =>
      DateFormat('dd/MM/yy', 'pt-BR')
          .format(Get.find<TransactionController>().selectedDate.value) !=
      DateFormat('dd/MM/yy', 'pt-BR').format(transaction.date));
}

void getOnlineTransactions() {}
