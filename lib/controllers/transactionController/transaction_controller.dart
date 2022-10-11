import 'package:cas/data/transactions.dart';

part 'get_transaction_calculations.dart';

class TransactionController {
  static getTransaction() {}

  static Map<String, dynamic> getTransactionCalculations({
    required List<dynamic> actualTransaction,
    required List<dynamic> allTransaction,
  }) {
    return implementGetTransactionCalculations(
      actualTransaction: actualTransaction,
      allTransaction: allTransaction,
    );
  }
}
