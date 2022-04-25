import 'package:cas/components/status.dart';
import 'package:cas/components/table_values.dart';

import '../data/dummy_transaction.dart';

import '../models/transaction.dart';

import '../components/day_flow.dart';
import '../components/transactions_file.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'dart:math';

class TransactionsList extends StatefulWidget {
  const TransactionsList({Key? key}) : super(key: key);

  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  final _transactions = {...DUMMY_TRANSACTION};

  @override
  Widget build(BuildContext context) {
    _addTrasanction(String category, String description, DateTime date,
        int status, double value, int type) {
      final newTransaction = Transaction(
        id: 'T' + Random().nextDouble().toString(),
        category: category,
        description: description,
        date: date,
        status: status,
        type: type,
        value: value,
      );

      /*setState(() {
      _transaction.add(newTransaction);
    });

    Navigator.of(context).pop();*/
    }

    return Scaffold(
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
                  child: ListView.builder(
                    itemCount: _transactions.length,
                    itemBuilder: (ctx, i) =>
                        TransactionsFile(_transactions.elementAt(i)),
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
        onPressed: () {},
        elevation: 8,
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
