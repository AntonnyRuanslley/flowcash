import '../data/dummy_transaction.dart';
import '../models/transaction.dart';
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
  double size() {
    return 17;
  }

  @override
  Widget build(BuildContext context) {
    final transactions = {...DUMMY_TRANSACTION};
    final _transaction = transactions.values;

    _recipeOrExpense(type) {
      var listValues = _transaction.map((listValues) {
        if (listValues.type == type) {
          return listValues.value;
        }
      });

      return listValues
          .map((values) => (values ?? 0.0 as double))
          .reduce((total, prox) => total + prox);
    }

    _balance() {
      return _recipeOrExpense(1) + _recipeOrExpense(2);
    }

    _balancePos() {
      if (_balance() > 0) {
        return true;
      } else {
        return false;
      }
    }

    _statusPendent(String status) {
      var listPendents = _transaction.map((listPendents) {
        if (listPendents.status == status) {
          return listPendents.status;
        }
      });
      return listPendents.length;
    }

    _addTrasanction(String category, String description, DateTime date,
        String status, double value, int type) {
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
                  Container(
                    height: 145,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                          start: 17, top: 10, end: 17),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Fluxo do dia:',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.date_range_outlined,
                                      color: Colors.white,
                                      size: 23,
                                    ),
                                    onPressed: () {}, //Mexer
                                  ),
                                  Text(
                                    '20/04/22', //Mexer
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: 19,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: 10, top: 72, end: 10, bottom: 5),
                    child: Container(
                      height: 120,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 213, 210, 210),
                            offset: Offset(1, 1),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_downward_rounded,
                                      color: Colors.green,
                                    ),
                                    Text(
                                      'Receita',
                                      style: TextStyle(
                                        fontSize: size(),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_upward_rounded,
                                      color: Colors.red,
                                    ),
                                    Text(
                                      'Despesa',
                                      style: TextStyle(
                                        fontSize: size(),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.attach_money_rounded,
                                      color: _balance() == 0
                                          ? Colors.yellow[800]
                                          : _balancePos()
                                              ? Colors.green
                                              : Colors.red,
                                    ),
                                    Text(
                                      'Saldo',
                                      style: TextStyle(
                                        fontSize: size(),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  _recipeOrExpense(1) == 0
                                      ? 'R\$ 0,00'
                                      : NumberFormat('R\$ #.00', 'pt-BR')
                                          .format(_recipeOrExpense(1)),
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: size(),
                                  ),
                                ),
                                Text(
                                  _recipeOrExpense(2) == 0
                                      ? 'R\$ 0,00'
                                      : NumberFormat(' R\$ #.00', 'pt-BR')
                                          .format(_recipeOrExpense(2)),
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: size(),
                                  ),
                                ),
                                Text(
                                  _balance() == 0
                                      ? 'R\$ 0,00'
                                      : NumberFormat(' R\$ #.00', 'pt-BR')
                                          .format(_balance()),
                                  style: TextStyle(
                                    color: _balance() == 0
                                        ? Colors.yellow[800]
                                        : _balancePos()
                                            ? Colors.green
                                            : Colors.red,
                                    fontSize: size(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                    start: 17, top: 4, end: 17, bottom: 3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Status',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${_statusPendent('Pendente')} Pendentes ${_statusPendent('Aprovado')} Aprovados',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (ctx, i) =>
                        TransactionsFile(transactions.values.elementAt(i)),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}