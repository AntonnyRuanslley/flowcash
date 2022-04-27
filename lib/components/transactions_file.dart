import 'package:cas/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionsFile extends StatelessWidget {
  final Transaction transaction;

  TransactionsFile(this.transaction);

  bool? _banlacePos(type) {
    if (type == 1) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 213, 210, 210),
              offset: Offset(1, 1),
              blurRadius: 3,
            ),
          ],
        ),
        child: CircleAvatar(
          radius: 20,
          child: Icon(
            _banlacePos(transaction.type)!
                ? Icons.arrow_downward_rounded
                : Icons.arrow_upward_rounded,
            color: _banlacePos(transaction.type)! ? Colors.green : Colors.red,
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
      ),
      title: Text(
        '${transaction.category} - ${transaction.status}',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        transaction.description,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Container(
        width: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              NumberFormat(' R\$ #.00', 'pt-BR').format(transaction.value),
              style: TextStyle(
                color:
                    _banlacePos(transaction.type)! ? Colors.green : Colors.red,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
