import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../components/components_cloud/day_flow.dart';
import '../data/categories.dart';
import '../data/transactions.dart';
import '../data/urls.dart';
import '../components/components_cloud/transaction_widgets/transaction_add.dart';
import '../components/components_cloud/status.dart';
import '../components/components_cloud/table_values.dart';
import '../components/components_cloud/title_top.dart';
import '../components/components_cloud/transaction_widgets/transactions_file.dart';
import '../components/components_cloud/settings.dart';


class TransactionsList extends StatefulWidget {
  const TransactionsList({Key? key}) : super(key: key);

  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<String>? getTransaction;

  List _allTransactions = [];

  Future<String> _getTransanctions() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse(
        "${urls['transactions']!}?date=${DateFormat('yyy-MM-dd', 'pt-BR').format(selectDate)}");
    var answer = await http.get(
      url,
      headers: {
        "Authorization": "Bearer ${sharedPreferences.getString('token')}",
      },
    );
    if (answer.statusCode == 200) {
      setState(() {
        transactions = jsonDecode(answer.body)['data'];
      });
      url = Uri.parse(
          "${urls['transactions']!}?month=${DateFormat('MM', 'pt-BR').format(selectDate)}");
      answer = await http.get(
        url,
        headers: {
          "Authorization": "Bearer ${sharedPreferences.getString('token')}",
        },
      );
      setState(() {
        _allTransactions = jsonDecode(answer.body)['data'];
      });
      url = Uri.parse(urls['categories']!);
      answer = await http.get(
        url,
        headers: {
          "Authorization": "Bearer ${sharedPreferences.getString('token')}",
        },
      );
      if (answer.statusCode == 200) {
        setState(() {
          categories = jsonDecode(answer.body)['data'];
        });
      }
      return "Success";
    } else {
      throw Exception(answer.statusCode);
    }
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
              Status(transactions),
              Expanded(
                child: FutureBuilder<String>(
                  future: getTransaction,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.primary),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text('Erro: ${snapshot.error}'),
                        ),
                      );
                    }
                    return transactions.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: sizeScreen * 0.01),
                                child: Container(
                                  height: sizeScreen * 0.25,
                                  child: const Image(
                                    image: AssetImage(
                                      'assets/images/vazio.png',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
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
                              return TransactionsFile(
                                  transactions[i], _refresh);
                            },
                          );
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
    _refresh();
    super.initState();
  }

  void _refresh() {
    setState(() {
      getTransaction = _getTransanctions();
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
