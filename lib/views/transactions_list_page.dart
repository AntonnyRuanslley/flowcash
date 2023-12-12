import 'package:flowcash/themes/app_theme.dart';
import 'package:flowcash/utils/open_form.dart';
import 'package:flowcash/views/transaction_form.dart';
import 'package:flowcash/widgets/transactionPage/transactions_list_body.dart';
import 'package:get/get.dart';

// import 'package:hive/hive.dart';
// import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

// import '../utils/open_form.dart';
// import '../views/transaction_form.dart';
import '../views/settings.dart';
import '../controllers/transactionController/transaction_controller.dart';
// import '../widgets/transactionPage/transactions_list_body.dart';
import '../widgets/transactionPage/tableValues/table_values.dart';
import '../widgets/transactionPage/title_top.dart';
import '../widgets/transactionPage/day_flow.dart';

class TransactionsListPage extends GetView<TransactionController> {
  TransactionsListPage({Key? key}) : super(key: key);

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: controller.scaffoldKey,
      backgroundColor: AppTheme.primaryColor,
      body: SafeArea(
        child: Container(
          color: Colors.grey[50],
          child: Column(
            children: [
              Stack(
                children: [
                  TitleTop(),
                  TableValues(),
                ],
              ),
              DayFlow(),
              TransactionsListBody(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryColor,
        child: Icon(Icons.add, color: AppTheme.secondyColor),
        onPressed: () => openForm(TransactionForm()),
        elevation: 8,
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      drawer: Settings(),
    );
  }
}
