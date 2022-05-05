import 'dart:convert';
import 'dart:math';

import '../data/dummy_transaction.dart';

import '../models/transaction.dart';

import '../components/transaction_form.dart';
import '../components/status.dart';
import '../components/table_values.dart';
import '../components/day_flow.dart';
import '../components/transactions_file.dart';

import 'package:flutter/material.dart';
import 'package:cas/data/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TransactionsList extends StatefulWidget {
  const TransactionsList({Key? key}) : super(key: key);

  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  List _transactions = [];

  Future<void> getTransanctions() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse(urls['transactions']!);
    var answer = await http.get(
      url,
      headers: {
        "Authorization": "Bearer ${sharedPreferences.getString('token')}",
      },
    );
    if (answer.statusCode == 200) {
      setState(() {
        _transactions = jsonDecode(answer.body)['data'];
      });
    }
  }

  @override
  void initState() {
    getTransanctions();
  }

  _refresh() {
    print("blz2");
    setState(() {});
    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      DUMMY_TRANSACTION.removeWhere((tr) => tr.id == id);
    });
  }

  _openForm() {
    showDialog(
        context: context,
        builder: (context) {
          return TransactionForm(_refresh, true);
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
                  DayFlow(),
                  TableValues(_transactions),
                ],
              ),
              Status(_transactions),
              Expanded(
                child: Container(
                  child: _transactions.isEmpty
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
                                _transactions[i], _removeTransaction);
                          },
                        ),
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
    );
  }
}
