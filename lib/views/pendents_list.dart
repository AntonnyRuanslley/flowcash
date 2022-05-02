import '../models/transaction.dart';

import '../data/dummy_transaction.dart';

import '../components/transactions_file.dart';

import 'package:flutter/material.dart';

class PendentsList extends StatefulWidget {
  const PendentsList({Key? key}) : super(key: key);

  @override
  State<PendentsList> createState() => _PendentsListState();
}

class _PendentsListState extends State<PendentsList> {
  @override
  Widget build(BuildContext context) {
    List<Transaction> _transactions = [...DUMMY_TRANSACTION];
    var width = MediaQuery.of(context).size.height;

    _removeTransaction(String id) {
      setState(() {
        DUMMY_TRANSACTION.removeWhere((tr) => tr.id == id);
      });
    }

    _pendentsList() {
      _transactions.removeWhere((tr) => tr.status == 2);
      return _transactions;
    }

    final List<Transaction> _pendents = _pendentsList();

    _toApprove() {
      setState(() {
        for (int i = 0; i < _transactions.length; i++) {
          _transactions[i].status = 2;
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transações pendentes',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      body: _pendents.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: width * 0.01),
                    child: Container(
                      height: width * 0.28,
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
                      'Sem pendencias!',
                      style: TextStyle(
                        fontSize: width * 0.055,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: _pendents.length,
              itemBuilder: (ctx, i) =>
                  TransactionsFile(_pendents.elementAt(i), _removeTransaction),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.check,
        ),
        onPressed: () => _toApprove(),
        elevation: 8,
      ),
    );
  }
}
