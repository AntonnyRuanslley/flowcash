import 'package:cas/data/categories.dart';
import 'package:cas/data/transactions.dart';

import 'package:cas/components/components_local/transaction_widgets/transaction_add.dart';
import 'package:cas/components/components_local/transaction_widgets/transactions_file.dart';
import 'package:cas/components/components_local/table_values.dart';
import 'package:cas/components/components_local/title_top.dart';
import 'package:cas/components/components_local/day_flow.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
  Widget build(BuildContext context) {
    final sizeScreen =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Container(
          color: Colors.grey[50],
          child: Column(
            children: [
              Stack(
                children: [
                  TitleTop(_onDrawer),
                  TableValues(transactions, _allTransactions),
                ],
              ),
              DayFlow(_selectedDate, selectDate),
              Expanded(
                child: transactions.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: sizeScreen * 0.25,
                            child: const Image(
                              image: AssetImage(
                                'assets/images/vazio.png',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            child: Text(
                              'Sem transações!',
                              style: TextStyle(
                                fontSize: sizeScreen * 0.05,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      )
                    : ListView.builder(
                        itemCount: transactions.length,
                        itemBuilder: (ctx, i) {
                          return TransactionsFile(transactions[i], _refresh);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.add,
        ),
        onPressed: () => _openForm(),
        elevation: 8,
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      drawer: Settings(),
    );
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

  _onDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  _openForm() {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: TransactionAdd(_refresh));
        });
  }
}
