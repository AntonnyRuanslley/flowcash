import 'package:flutter/material.dart';

import '../../../controllers/transactionController/transaction_controller.dart';
import '../../../utils/format_value.dart';
import '../../../utils/screen_size.dart';
import '../../../widgets/transactionPage/tableValues/custom_title.dart';
import '../../../widgets/transactionPage/tableValues/custom_value.dart';

class TableValues extends StatelessWidget {
  final List<dynamic> actualTransaction;
  final List<dynamic> allTransaction;

  TableValues(this.actualTransaction, this.allTransaction);

  @override
  Widget build(BuildContext context) {
    final sizeScreen = ScreenSizes.getScreenHeightSize(context);

    final transactionCalculations =
        TransactionController.getTransactionCalculations(
      actualTransaction: actualTransaction,
      allTransaction: allTransaction,
    );

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
                        color: FormatValue.getSelectColor(
                            transactionCalculations['balance']),
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
                        label: FormatValue.getMoneyFormat(
                          transactionCalculations['recipe'],
                        ),
                      ),
                      CustomValue(
                        color: Colors.red,
                        label: FormatValue.getMoneyFormat(
                          transactionCalculations['expense'] * -1,
                        ),
                      ),
                      CustomValue(
                        color: FormatValue.getSelectColor(
                            transactionCalculations['balance']),
                        label: FormatValue.getMoneyFormat(
                          transactionCalculations['balance'],
                        ),
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
                              color: FormatValue.getSelectColor(
                                  transactionCalculations['initialBalance']),
                              label: 'Saldo inicial',
                            ),
                            CustomTitle(
                              icon: Icons.monetization_on_sharp,
                              color: FormatValue.getSelectColor(
                                  transactionCalculations['finalBalance']),
                              label: 'Saldo final',
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomValue(
                                color: FormatValue.getSelectColor(
                                    transactionCalculations['initialBalance']),
                                label: FormatValue.getMoneyFormat(
                                    transactionCalculations['initialBalance'])),
                            CustomValue(
                              color: FormatValue.getSelectColor(
                                  transactionCalculations['finalBalance']),
                              label: FormatValue.getMoneyFormat(
                                transactionCalculations['finalBalance'],
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
