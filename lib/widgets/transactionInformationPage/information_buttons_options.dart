import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/app_theme.dart';
import '../../models/transaction.dart';
import '../../utils/open_form.dart';
import '../../utils/screen_size.dart';
import '../../utils/alert/alert_dialog.dart';
import '../../controllers/transactionController/transaction_controller.dart';
import '../../views/transaction_form.dart';

class InformationButtonsOptions extends GetView<TransactionController> {
  final Transaction transaction;

  const InformationButtonsOptions({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final sizeScreen = ScreenSizes.getScreenWidthSize(context);
    return Padding(
      padding: EdgeInsets.only(
        left: sizeScreen * 0.01,
        right: sizeScreen * 0.01,
        bottom: sizeScreen * 0.03,
      ),
      child: SizedBox(
        width: sizeScreen * 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              child: Text(
                'Excluir',
                style: TextStyle(
                    color: AppTheme.secondyColor,
                    fontSize: sizeScreen * 0.051,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () => alertDialog(
                title: "Deseja realmente excluir?",
                subtitle: "A transação será excluída permanentemente!",
                function: () => controller.deleteTransaction(
                  id: transaction.id!,
                ),
              ),
            ),
            SizedBox(width: sizeScreen * 0.03),
            InkWell(
              child: Text(
                'Editar',
                style: TextStyle(
                    color: AppTheme.secondyColor,
                    fontSize: sizeScreen * 0.051,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () => openForm(TransactionForm(transaction: transaction)),
            ),
          ],
        ),
      ),
    );
  }
}
