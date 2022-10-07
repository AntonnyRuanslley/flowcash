import 'package:cas/data/transactions.dart';
import 'package:cas/widgets/transactionPage/tableValues/custom_title.dart';
import 'package:cas/widgets/transactionPage/tableValues/custom_value.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TableValues extends StatelessWidget {
  final List actualTransaction;
  final List allTransaction;

  TableValues(this.actualTransaction, this.allTransaction);

  @override
  Widget build(BuildContext context) {
    final sizeScreen =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

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

    bool _balancePos() {
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
          if (DateTime.parse(listValues['date'].toString())
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

    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: sizeScreen * 0.015,
        top: sizeScreen * 0.1,
        end: sizeScreen * 0.015,
        bottom: sizeScreen * 0.01,
      ),
      child: Container(
        height: sizeScreen * 0.28,
        width: double.infinity,
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
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: sizeScreen * 0.027,
                top: sizeScreen * 0.027,
                right: sizeScreen * 0.027,
                bottom: sizeScreen * 0.01,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTitle(
                        icon: Icons.arrow_downward_rounded,
                        color: Colors.green,
                        label: 'Receita',
                      ),
                      CustomTitle(
                        icon: Icons.arrow_upward_rounded,
                        color: Colors.red,
                        label: 'Despesa',
                      ),
                      CustomTitle(
                        icon: Icons.attach_money_rounded,
                        color: _balance() == 0
                            ? Colors.yellow[800]
                            : _balancePos()
                                ? Colors.green
                                : Colors.red,
                        label: 'Saldo',
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomValue(
                        color: Colors.green,
                        label: _recipeOrExpense(1) == 0
                            ? 'R\$ 0,00'
                            : NumberFormat('R\$ #.00', 'pt-BR')
                                .format(_recipeOrExpense(1)),
                      ),
                      CustomValue(
                        color: Colors.red,
                        label: _recipeOrExpense(2) == 0
                            ? 'R\$ 0,00'
                            : NumberFormat(' R\$ #.00', 'pt-BR')
                                .format(_recipeOrExpense(2) * -1),
                      ),
                      CustomValue(
                        color: _balance() == 0
                            ? Colors.yellow[800]
                            : _balancePos()
                                ? Colors.green
                                : Colors.red,
                        label: _balance() == 0
                            ? 'R\$ 0,00'
                            : NumberFormat(' R\$ #.00', 'pt-BR')
                                .format(_balance()),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Visibility(
              visible: true,
              child: Column(
                children: [
                  Divider(
                    height: sizeScreen * 0.005,
                    thickness: 2,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: sizeScreen * 0.027,
                      top: sizeScreen * 0.01,
                      right: sizeScreen * 0.027,
                      bottom: sizeScreen * 0.027,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTitle(
                              icon: Icons.monetization_on_sharp,
                              color: _initialBalance() == 0
                                  ? Colors.yellow[800]
                                  : _initialBalance() > 0
                                      ? Colors.green
                                      : Colors.red,
                              label: 'Saldo inicial',
                            ),
                            CustomTitle(
                              icon: Icons.monetization_on_sharp,
                              color: _initialBalance() == 0
                                  ? Colors.yellow[800]
                                  : _initialBalance() > 0
                                      ? Colors.green
                                      : Colors.red,
                              label: 'Saldo final',
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomValue(
                                color: _initialBalance() == 0
                                    ? Colors.yellow[800]
                                    : _initialBalance() > 0
                                        ? Colors.green
                                        : Colors.red,
                                label: _initialBalance() == 0
                                    ? 'R\$ 0,00'
                                    : NumberFormat(' R\$ #.00', 'pt-BR')
                                        .format(_initialBalance())),
                            CustomValue(
                              color: _finalBalance() == 0
                                  ? Colors.yellow[800]
                                  : _finalBalance() > 0
                                      ? Colors.green
                                      : Colors.red,
                              label: _finalBalance() == 0
                                  ? 'R\$ 0,00'
                                  : NumberFormat(' R\$ #.00', 'pt-BR').format(
                                      _finalBalance(),
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
          ],
        ),
      ),
    );
  }
}
