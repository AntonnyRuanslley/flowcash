import 'dart:convert';

import '../components/transaction_form.dart';
import '../components/status.dart';
import '../components/table_values.dart';
import '../components/day_flow.dart';
import '../components/transactions_file.dart';
import '../components/settings.dart';
import 'package:cas/data/urls.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TransactionsList extends StatefulWidget {
  const TransactionsList({Key? key}) : super(key: key);

  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  DateTime _selectDate = DateTime.now();
  List _transactions = [];
  Future<String>? getTransaction;

  Future<String> _getTransanctions() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse("${urls['transactions']!}?date=${_selectDate}");
    var answer = await http.get(
      url,
      headers: {
        "Authorization": "Bearer ${sharedPreferences.getString('token')}",
      },
    );
    if (answer.statusCode == 200) {
      print(answer.statusCode);
      setState(() {
        _transactions = jsonDecode(answer.body)['data'];
      });
      return "Sucesso";
    } else {
      print(answer.statusCode);
      return "Erro";
    }
  }

  _refresh(String id) {
    setState(() {});
  }

  initState() {
    getTransaction = _getTransanctions();
    super.initState();
  }

  _selectedDate(_newDate) {
    setState(() {
      _selectDate = _newDate;
      getTransaction = _getTransanctions();
    });
  }

  _openForm() {
    showDialog(
        context: context,
        builder: (context) {
          return TransactionForm(true);
        });
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  DayFlow(_selectedDate, _selectDate),
                  TableValues(_transactions),
                ],
              ),
              Status(_transactions),
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
                    return _transactions.isEmpty
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
                            itemCount: _transactions.length,
                            itemBuilder: (ctx, i) {
                              return TransactionsFile(
                                  _transactions[i], _refresh);
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
}
