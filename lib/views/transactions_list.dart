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
  _addTrasanction(String description, String category, double value, int type,
      DateTime date) {
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
                  TableValues(DUMMY_TRANSACTION),
                ],
              ),
              Status(DUMMY_TRANSACTION),
              Expanded(
                child: Container(
                  child: DUMMY_TRANSACTION.isEmpty
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
                          itemCount: DUMMY_TRANSACTION.length,
                          itemBuilder: (ctx, i) => TransactionsFile(
                              DUMMY_TRANSACTION.elementAt(i),
                              _removeTransaction),
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
