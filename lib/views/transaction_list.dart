import 'dart:math';

import 'package:cas/data/dummy_transaction.dart';

import '../components/transaction_form.dart';

import 'package:flutter/material.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({Key? key}) : super(key: key);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  bool _balancePos = true;

  double size() {
    return 17;
  }

  @override
  Widget build(BuildContext context) {
    final transactions = {...DUMMY_TRANSACTION};

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 145,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: 15, end: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Fluxo do dia:',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 22,
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
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 19,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: 75,
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
                                    Icons.arrow_upward_rounded,
                                    color: Colors.green,
                                  ),
                                  Text(
                                    'Receita:',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: size(),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.arrow_downward_rounded,
                                    color: Colors.red,
                                  ),
                                  Text(
                                    'Despesa:',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: size(),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.attach_money_rounded,
                                    color:
                                        _balancePos ? Colors.green : Colors.red,
                                  ),
                                  Text(
                                    'Saldo:',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
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
                                'R\$ XX,XX', //Mexer
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: size(),
                                ),
                              ),
                              Text(
                                'R\$ XX,XX', //Mexer
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: size(),
                                ),
                              ),
                              Text(
                                'R\$ XX,XX', //Mexer
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: size(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (ctx, i) =>
                      TransactionForm(transactions.values.elementAt(i)),
                ),
              ),
            ),
          ],
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
