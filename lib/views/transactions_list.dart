import 'package:cas/components/transaction_form.dart';
import 'package:cas/components/status.dart';
import 'package:cas/components/table_values.dart';

import '../data/dummy_transaction.dart';

import '../components/day_flow.dart';
import '../components/transactions_file.dart';

import 'package:flutter/material.dart';

class TransactionsList extends StatefulWidget {
  const TransactionsList({Key? key}) : super(key: key);

  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  final _transactions = [...DUMMY_TRANSACTION];

  _addTransaction() {
    showDialog(
        context: context,
        builder: (context) {
          return TransanctionForm();
        });
  }

  @override
  Widget build(BuildContext context) {
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
        onPressed: () => _addTransaction(),
        elevation: 8,
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
