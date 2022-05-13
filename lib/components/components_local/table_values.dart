import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TableValues extends StatelessWidget {
  final List transaction;

  TableValues(this.transaction);

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size.height;

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

    _title(icon, color, label) {
      return Row(
        children: [
          Icon(
            icon,
            color: color,
            size: sizeScreen * 0.04,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: sizeScreen * 0.029,
            ),
          ),
        ],
      );
    }

    _value(label, color) {
      return Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: sizeScreen * 0.029,
        ),
      );
    }

    return Padding(
      padding:
          EdgeInsetsDirectional.only(start: 10, top: 60, end: 10, bottom: 5),
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
                  _title(Icons.arrow_downward_rounded, Colors.green, 'Receita'),
                  _title(Icons.arrow_upward_rounded, Colors.red, 'Despesa'),
                  _title(
                      Icons.attach_money_rounded,
                      _balance() == 0
                          ? Colors.yellow[800]
                          : _balancePos()
                              ? Colors.green
                              : Colors.red,
                      'Saldo'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _value(
                      _recipeOrExpense(1) == 0
                          ? 'R\$ 0,00'
                          : NumberFormat('R\$ #.00', 'pt-BR')
                              .format(_recipeOrExpense(1)),
                      Colors.green),
                  _value(
                      _recipeOrExpense(2) == 0
                          ? 'R\$ 0,00'
                          : NumberFormat(' R\$ #.00', 'pt-BR')
                              .format(_recipeOrExpense(2) * -1),
                      Colors.red),
                  _value(
                      _balance() == 0
                          ? 'R\$ 0,00'
                          : NumberFormat(' R\$ #.00', 'pt-BR')
                              .format(_balance()),
                      _balance() == 0
                          ? Colors.yellow[800]
                          : _balancePos()
                              ? Colors.green
                              : Colors.red),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
