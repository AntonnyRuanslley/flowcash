import 'package:cas/controllers/transactionController/transaction_controller.dart';
import 'package:cas/utils/confirmation_alert_dialog.dart';
import 'package:cas/utils/open_form.dart';
import 'package:cas/utils/screen_size.dart';
import 'package:cas/views/transaction_form.dart';
import 'package:flutter/material.dart';

class InformationButtonsOptions extends StatelessWidget {
  final transaction;
  final category;
  final Function() onRefresh;

  const InformationButtonsOptions({
    Key? key,
    required this.transaction,
    required this.category,
    required this.onRefresh,
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
                  TransactionController.deleteTransaction(
                    context: context,
                    id: transaction['id'],
                    onRefresh: onRefresh,
                  );
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
              onPressed: () => openForm(
                context,
                TransactionForm(
                  transaction: transaction,
                  category: category,
                  onRefresh: onRefresh,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
