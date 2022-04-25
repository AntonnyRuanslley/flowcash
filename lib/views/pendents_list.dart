import 'package:cas/models/transaction.dart';

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
    final List<Transaction> _transactions = [...DUMMY_TRANSACTION];

    final List<Transaction>? _pendents = _transactions
        .map(
          (pendent) {
            if (pendent.status == 2) {
              return pendent;
            }
          },
        )
        .cast<Transaction>()
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transações pendentes',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      body: _pendents!.isEmpty
          ? const Text("Sem pendencias")
          : ListView.builder(
              itemCount: _pendents.length,
              itemBuilder: (ctx, i) => TransactionsFile(_pendents.elementAt(i)),
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
