import 'package:cas/data/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TableValues extends StatelessWidget {
  final List actualTransaction;
  final List allTransaction;

  TableValues(this.actualTransaction, this.allTransaction);

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size.height;

    double _recipeOrExpense(type) {
      if (actualTransaction.isEmpty) {
        return 0;
      } else {
        var listValues = actualTransaction.map((listValues) {
          if (listValues['type'] == type) {
            return double.parse(listValues['value'].toString());
          }
        });
        return listValues
            .map((values) => (values ?? 0.0))
            .reduce((total, prox) => total + prox);
      }
    }

    double _balance() {
      return _recipeOrExpense(1) + (_recipeOrExpense(2) * -1);
    }

    _balancePos() {
      if (_balance() > 0) {
        return true;
      } else {
        return false;
      }
    }

    double _initialBalance() {
      if (allTransaction.isEmpty) {
        return 0;
      } else {
        var listValues = allTransaction.map((listValues) {
          if (DateTime.parse(listValues['date'])
              .isBefore(selectDate.subtract(const Duration(days: 1)))) {
            if (listValues['type'] == 2) {
              return (double.parse(listValues['value'].toString()) * -1);
            } else {
              return double.parse(listValues['value'].toString());
            }
          }
        });
        return listValues
            .map((values) => (values ?? 0.0))
            .reduce((total, prox) => total + prox);
      }
    }

    _finalBalance() {
      return _initialBalance() + _balance();
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
      padding: EdgeInsetsDirectional.only(
        start: sizeScreen * 0.018,
        top: sizeScreen * 0.11,
        end: sizeScreen * 0.018,
        bottom: sizeScreen * 0.01,
      ),
      child: Container(
        height: sizeScreen * 0.28,
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
          padding: EdgeInsets.all(18),
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
                  _title(
                      Icons.monetization_on_sharp,
                      _initialBalance() == 0
                          ? Colors.yellow[800]
                          : _initialBalance() > 0
                              ? Colors.green
                              : Colors.red,
                      'Saldo inicial'),
                  _title(
                      Icons.monetization_on_sharp,
                      _finalBalance() == 0
                          ? Colors.yellow[800]
                          : _finalBalance() > 0
                              ? Colors.green
                              : Colors.red,
                      'Saldo final'),
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
                  _value(
                      _initialBalance() == 0
                          ? 'R\$ 0,00'
                          : NumberFormat(' R\$ #.00', 'pt-BR')
                              .format(_initialBalance()),
                      _initialBalance() == 0
                          ? Colors.yellow[800]
                          : _initialBalance() > 0
                              ? Colors.green
                              : Colors.red),
                  _value(
                      _finalBalance() == 0
                          ? 'R\$ 0,00'
                          : NumberFormat(' R\$ #.00', 'pt-BR')
                              .format(_finalBalance()),
                      _finalBalance() == 0
                          ? Colors.yellow[800]
                          : _finalBalance() > 0
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
