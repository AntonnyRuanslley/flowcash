import 'dart:convert';

import 'package:cas/data/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../data/dummy_transaction.dart';

import '../models/transaction.dart';

import '../components/transaction_form.dart';
import '../components/status.dart';
import '../components/table_values.dart';
import '../components/day_flow.dart';
import '../components/transactions_file.dart';

import 'package:flutter/material.dart';

import 'dart:math';

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

    setState(() {
      _transactions = jsonDecode(answer.body)['data'];
    });
  }

  @override
  void initState() {
    getTransanctions();
  }

  /*Future<String> getCategories() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse(urls['categories']!);
    var answer = await http.get(url, headers: {
      "Authorization": "Bearer ${sharedPreferences.getString('token')}"
    });
    if (answer.statusCode == 200) {
      setState(() {
        _categories = jsonDecode(answer.body)['data'];
      });
      return "Sucesso!";
    } else {
      throw Exception('Erro ao carregar os dados, tente novamente mais tarde!');
    }
    
  }*/

  _addTrasanction(String description, String category, double value, int type,
      DateTime date) {
    /*Future<bool> login() async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var url = Uri.parse('http://100.64.1.6:8000/transactions');
      var answer = await http.post(
        url,
        body: {
          'description' : description,
          'category' : category, 
          'value' : value,
          'type' : type,
          'date' : date,
        },
        head: {
          'Authorization' : token,
        }
      );
      if (answer.statusCode == 200) {
        if (isChecked) {
          await sharedPreferences.setString('token',
              jsonDecode(answer.body)['token'].toString().split('|')[1]);
        }
        return true;
      } else {
        return false;
      }
    }*/
    final newTransaction = Transaction(
      id: 'T' + Random().nextInt(1000).toString(),
      category: category,
      description: description,
      date: date,
      status: 1,
      type: type,
      value: value,
    );
    setState(() {
      DUMMY_TRANSACTION.add(newTransaction);
    });

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
          return TransactionForm(_addTrasanction, true);
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
