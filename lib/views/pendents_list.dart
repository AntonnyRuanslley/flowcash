import '../components/transactions_file.dart';
import '../data/dummy_transaction.dart';

import 'package:flutter/material.dart';

class PendentsList extends StatefulWidget {
  const PendentsList({Key? key}) : super(key: key);

  @override
  State<PendentsList> createState() => _PendentsListState();
}

class _PendentsListState extends State<PendentsList> {
  @override
  Widget build(BuildContext context) {
    final _transactions = {...DUMMY_TRANSACTION};
    final _transaction = _transactions.values;
    final _pendents = _transaction.map((pendent) {
      if (pendent.status == "Aprovado") {
        return pendent;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transações pendentes',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _transactions.length,
        itemBuilder: (ctx, i) =>
            TransactionsFile(_transactions.values.elementAt(i)),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.check,
        ),
        onPressed: () {},
        elevation: 8,
      ),
    );
  }
}
