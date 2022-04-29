import '../data/dummy_transaction.dart';

import '../components/add_transaction.dart';
import '../components/status.dart';
import '../components/table_values.dart';
import '../components/day_flow.dart';
import '../components/transactions_file.dart';

import 'package:flutter/material.dart';

class TransactionsList extends StatefulWidget {
  const TransactionsList({Key? key}) : super(key: key);

  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  _addTransaction() {
    setState(() {
      showDialog(
          context: context,
          builder: (context) {
            return AddTransaction();
          });
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
                  TableValues(DUMMY_TRANSACTION),
                ],
              ),
              Status(DUMMY_TRANSACTION),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemCount: DUMMY_TRANSACTION.length,
                    itemBuilder: (ctx, i) =>
                        TransactionsFile(DUMMY_TRANSACTION.elementAt(i)),
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
