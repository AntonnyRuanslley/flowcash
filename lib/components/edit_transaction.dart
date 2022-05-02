import '../components/transaction_form.dart';

import '../data/dummy_transaction.dart';

import '../models/transaction.dart';

import 'package:flutter/material.dart';

import 'dart:math';

class EditTransaction extends StatefulWidget {
  @override
  State<EditTransaction> createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  _addTrasanction(String description, String category, DateTime date,
      double value, int type) {
    if (description.isEmpty || category.isEmpty || value <= 0) {
      return;
    }
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        "Nova transação",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      //content: TransactionForm(),
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 13, right: 17, bottom: 10),
          child: Container(
            width: width * 1,
            padding: const EdgeInsets.all(3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    child: Text(
                      'Cancelar',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: width * 0.047,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                SizedBox(width: width * 0.03),
                TextButton(
                    child: Text(
                      'Adicionar',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: width * 0.047,
                          fontWeight: FontWeight.bold),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
