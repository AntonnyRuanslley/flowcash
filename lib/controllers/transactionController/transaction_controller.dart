import 'package:cas/data/transactions.dart';
import 'package:cas/utils/alert_dialog.dart';
import 'package:cas/utils/messages.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'get_transaction_calculations.dart';
part 'create_transaction.dart';
part 'delete_transaction.dart';

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

  static Future<void> createTransaction({
    required BuildContext context,
    required Map<String, dynamic> newTransaction,
    required Function() onRefresh,
  }) {
    return implementCreateTransaction(
      context: context,
      newTransaction: newTransaction,
      onRefresh: onRefresh,
    );
  }

  static Future<void> deleteTransaction({
    required BuildContext context,
    required int id,
    required Function() onRefresh,
  }) {
    return implementDeleteTransaction(
      context: context,
      id: id,
      onRefresh: onRefresh,
    );
  }
}
