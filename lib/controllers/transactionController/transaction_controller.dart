import 'package:cas/data/transactions.dart';
import 'package:cas/utils/messages.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'get_transaction_calculations.dart';
part 'new_transaction.dart';

class TransactionController {
  static getTransaction() {
    return;
  }

  static Map<String, dynamic> getTransactionCalculations({
    required List<dynamic> actualTransaction,
    required List<dynamic> allTransaction,
  }) {
    return implementGetTransactionCalculations(
      actualTransaction: actualTransaction,
      allTransaction: allTransaction,
    );
  }

  static Future<void> newTransaction({
    required BuildContext context,
    required Map<String, dynamic> newTransaction,
    required Function() onRefresh,
  }) {
    return implementNewTransaction(
      context: context,
      newTransaction: newTransaction,
      onRefresh: onRefresh,
    );
  }
}
