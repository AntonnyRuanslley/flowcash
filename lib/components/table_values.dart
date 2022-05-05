//import '../models/transaction.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TableValues extends StatelessWidget {
  final List transaction;

  TableValues(this.transaction);

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size.height;

    double fontSize() {
      return sizeScreen * 0.029;
    }

    double fontIcon() {
      return sizeScreen * 0.04;
    }

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
          EdgeInsetsDirectional.only(start: 10, top: 70, end: 10, bottom: 5),
      child: Container(
        height: sizeScreen * 0.19,
        width: MediaQuery.of(context).size.width * 1,
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
                        size: fontIcon(),
                      ),
                      Text(
                        'Receita',
                        style: TextStyle(
                          fontSize: fontSize(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_upward_rounded,
                        color: Colors.red,
                        size: fontIcon(),
                      ),
                      Text(
                        'Despesa',
                        style: TextStyle(
                          fontSize: fontSize(),
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
                        size: fontIcon(),
                      ),
                      Text(
                        'Saldo',
                        style: TextStyle(
                          fontSize: fontSize(),
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
                      fontSize: fontSize(),
                    ),
                  ),
                  Text(
                    _recipeOrExpense(2) == 0
                        ? 'R\$ 0,00'
                        : NumberFormat(' R\$ #.00', 'pt-BR')
                            .format(_recipeOrExpense(2) * -1),
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: fontSize(),
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
                      fontSize: fontSize(),
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
