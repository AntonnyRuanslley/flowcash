import 'package:flutter/material.dart';

import '../../controllers/transactionController/transaction_controller.dart';
import '../../utils/confirmation_alert_dialog.dart';
import '../../utils/open_form.dart';
import '../../utils/screen_size.dart';
import '../../views/transaction_form.dart';

class InformationButtonsOptions extends StatelessWidget {
  final transaction;

  const InformationButtonsOptions({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeScreen = ScreenSizes.getScreenWidthSize(context);
    return Padding(
      padding: EdgeInsets.only(
        left: sizeScreen * 0.03,
        right: sizeScreen * 0.03,
        bottom: sizeScreen * 0.03,
      ),
      child: SizedBox(
        width: sizeScreen * 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              child: Text(
                'Excluir',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: sizeScreen * 0.051,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () => confirmationAlertDialog(
                context: context,
                msgTitle: "Deseja realmente excluir?",
                completeMsg: "A transação será excluída permanentemente!",
                function: () {
                  // TransactionController.deleteTransaction(
                  //   context: context,
                  //   id: transaction['id'],
                  //   onRefresh: onRefresh,
                  // );
                },
              ),
            ),
            SizedBox(width: sizeScreen * 0.03),
            TextButton(
                child: Text(
                  'Editar',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: sizeScreen * 0.051,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {}
                //  openForm(
                //   context,
                //   TransactionForm(
                //     transaction: transaction,
                //     onRefresh: onRefresh,
                //   ),
                // ),
                ),
          ],
        ),
      ),
    );
  }
}
