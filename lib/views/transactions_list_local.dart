import 'package:cas/data/categories.dart';
import 'package:cas/data/transactions.dart';

import 'package:cas/views/transaction_add.dart';
import 'package:cas/utils/open_form.dart';
import 'package:cas/widgets/transactionPage/transactions_list_body.dart';
import 'package:cas/widgets/transactionPage/transactions_tile.dart';
import 'package:cas/widgets/transactionPage/tableValues/table_values.dart';
import 'package:cas/widgets/transactionPage/title_top.dart';
import 'package:cas/widgets/transactionPage/day_flow.dart';
import 'package:cas/components/components_local/settings.dart';

import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class TransactionsListLocal extends StatefulWidget {
  const TransactionsListLocal({Key? key}) : super(key: key);

  @override
  State<TransactionsListLocal> createState() => _TransactionsListLocalState();
}

class _TransactionsListLocalState extends State<TransactionsListLocal> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _transactionsBox = Hive.box('transactions');
  final _categoriesBox = Hive.box('categories');

  Future<String>? getTransaction;
  List _allTransactions = [];

  void _getTransanctions() {
    final data = _transactionsBox.keys.map((key) {
      final value = _transactionsBox.get(key);
      return {
        "id": key,
        "description": value["description"],
        "category_id": value['category_id'],
        "value": value['value'],
        "type": value['type'],
        "date": value['date'],
      };
    }).toList();

    setState(() {
      transactions = data.reversed.toList();
      _allTransactions = data.reversed.toList();
      transactions.removeWhere((transaction) =>
          DateFormat('dd/MM/yy', 'pt-BR').format(selectDate) !=
          DateFormat('dd/MM/yy', 'pt-BR').format(transaction['date']));
    });
  }

  void _getCategories() {
    final data = _categoriesBox.keys.map((key) {
      final value = _categoriesBox.get(key);
      return {
        "id": key,
        "name": value["name"],
      };
    }).toList();

    setState(() {
      categories = data.reversed.toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  _refresh() {
    setState(() {
      _getTransanctions();
      _getCategories();
    });
  }

  _selectedDate(_newDate) {
    setState(() {
      selectDate = _newDate;
    });
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Container(
          color: Colors.grey[50],
          child: Column(
            children: [
              Stack(
                children: [
                  TitleTop(
                    scaffoldKey: scaffoldKey,
                  ),
                  TableValues(transactions, _allTransactions),
                ],
              ),
              DayFlow(_selectedDate, selectDate),
              TransactionsListBody(
                transactions: transactions,
                onRefresh: _refresh,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(Icons.add),
        onPressed: () => openForm(context, TransactionAdd(onRefresh: _refresh)),
        elevation: 8,
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      drawer: Settings(),
    );
  }
}
