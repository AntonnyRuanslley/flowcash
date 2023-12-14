// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../models/transaction.dart';
import '../../utils/alert/alert_dialog.dart';
import '../../utils/loading_alert.dart';
import '../../common/ui.dart';
import '../../services/settings_service.dart';

part 'get_transaction_calculations.dart';
part 'create_transaction.dart';
part 'update_transaction.dart';
part 'delete_transaction.dart';

class TransactionController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final showFullTable = false.obs;

  final allTransactions = <Transaction>[].obs;
  final dayTransactions = <Transaction>[].obs;
  final transactionsCalculations = <String, dynamic>{}.obs;
  final selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    refresh();
  }

  void refresh() {
    getTransanctions();
    getTransactionCalculations();
  }

  void setDate(DateTime _newDate) {
    selectedDate.value = _newDate;
    refresh();
  }

  void getTransanctions() {
    if (Get.find<SettingsService>().isOnline) {
      getOnlineTransactions();
    } else {
      getOfflineTransactions();
    }
  }

  void getOfflineTransactions() {
    final transactionsBox = Hive.box('transactions');

    allTransactions.value = transactionsBox.keys.map((key) {
      final data = transactionsBox.get(key);
      data.addAll({"id": key});
      return Transaction.setTransactionModel(data: data);
    }).toList();

    dayTransactions.value = [...allTransactions.reversed.toList()];
    dayTransactions.removeWhere((transaction) =>
        DateFormat('dd/MM/yy', 'pt-BR').format(selectedDate.value) !=
        DateFormat('dd/MM/yy', 'pt-BR').format(transaction.date));
  }

  void getOnlineTransactions() {}

  void getTransactionCalculations() {
    transactionsCalculations.value = implementGetTransactionCalculations(
      actualTransaction: dayTransactions.value,
      allTransaction: allTransactions.value,
      selectedDate: selectedDate.value,
    );
  }

  Future<void> createTransaction({
    required Map<String, dynamic> newTransaction,
  }) {
    return implementCreateTransaction(
      newTransaction: newTransaction,
    );
  }

  Future<void> updateTransaction({
    required int transactionId,
    required Map<String, dynamic> updateTransaction,
  }) {
    return implementUpdateTransaction(
      transactionId: transactionId,
      updateTransaction: updateTransaction,
    );
  }

  Future<void> deleteTransaction({required int id}) {
    return implementDeleteTransaction(id: id);
  }
}
