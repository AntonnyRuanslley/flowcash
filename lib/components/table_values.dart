//import '../models/transaction.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TableValues extends StatelessWidget {
  final List transaction;

  TableValues(this.transaction);

  double size() {
    return 17;
  }

  @override
  Widget build(BuildContext context) {
    _recipeOrExpense(int type) {
      if (transaction.isEmpty) {
        return 0;
      } else {
        var listValues = transaction.map((listValues) {
          if (listValues['type'] == type) {
            return listValues['value'];
          }
        });
        return listValues
            .map((values) => (values ?? 0.0))
            .reduce((total, prox) => total + prox);
      }
    }

    _balance() {
      return _recipeOrExpense(1) - _recipeOrExpense(2);
    }

    _balancePos() {
      if (_balance() > 0) {
        return true;
      } else {
        return false;
      }
    }

    return Padding(
      padding:
          EdgeInsetsDirectional.only(start: 10, top: 72, end: 10, bottom: 5),
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
                            .format(_recipeOrExpense(2) * -1),
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: size(),
                    ),
                  ),
                  Text(
                    _balance() == 0
                        ? 'R\$ 0,00'
                        : NumberFormat(' R\$ #.00', 'pt-BR').format(_balance()),
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
    );
  }
}
