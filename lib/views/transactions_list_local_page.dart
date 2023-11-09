import 'package:get/get.dart';

import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../utils/open_form.dart';
import '../views/transaction_form.dart';
import '../views/settings.dart';
import '../controllers/transaction_controller/transaction_controller.dart';
import '../widgets/transactionPage/transactions_list_body.dart';
import '../widgets/transactionPage/tableValues/table_values.dart';
import '../widgets/transactionPage/title_top.dart';
import '../widgets/transactionPage/day_flow.dart';

class TransactionsListLocalPage extends GetView<TransactionController> {
  TransactionsListLocalPage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  // final _transactionsBox = Hive.box('transactions');
  // final _categoriesBox = Hive.box('categories');

  // Future<String>? getTransaction;
  // List _allTransactions = [];

  // void _getTransanctions() {
  //   final data = _transactionsBox.keys.map((key) {
  //     final value = _transactionsBox.get(key);
  //     return {
  //       "id": key,
  //       "description": value['description'],
  //       "category_id": value['category_id'],
  //       "value": value['value'],
  //       "type": value['type'],
  //       "date": value['date'],
  //     };
  //   }).toList();

  //   setState(() {
  //     transactions = data.reversed.toList();
  //     _allTransactions = data.reversed.toList();
  //     transactions.removeWhere((transaction) =>
  //         DateFormat('dd/MM/yy', 'pt-BR').format(selectDate) !=
  //         DateFormat('dd/MM/yy', 'pt-BR').format(transaction['date']));
  //   });
  // }

  // void _getCategories() {
  //   final data = _categoriesBox.keys.map((key) {
  //     final value = _categoriesBox.get(key);
  //     return {
  //       "id": key,
  //       "name": value["name"],
  //     };
  //   }).toList();

  //   setState(() {
  //     categories = data.reversed.toList();
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _refresh();
  //   controller.getTransanctions();
  // }

  // _refresh() {
  //   setState(() {
  //     _getTransanctions();
  //     _getCategories();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    controller.getTransanctions();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Container(
          color: Colors.grey[50],
          child: Obx(() {
            return Column(
              children: [
                Stack(
                  children: [
                    TitleTop(scaffoldKey: scaffoldKey),
                    TableValues(
                      controller.transactions,
                      controller.dayTransactions,
                    ),
                  ],
                ),
                DayFlow(
                  oldDate: controller.selectedDate.value,
                  selectedDate: controller.setDate,
                ),
                // TransactionsListBody(
                //   transactions: transactions,
                //   onRefresh: _refresh,
                // ),
              ],
            );
          }),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Theme.of(context).colorScheme.primary,
      //   child: Icon(Icons.add),
      //   onPressed: () =>
      //       openForm(context, TransactionForm(onRefresh: _refresh)),
      //   elevation: 8,
      // ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      drawer: Settings(),
    );
  }
}
