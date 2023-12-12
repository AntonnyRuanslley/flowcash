import 'package:flowcash/themes/app_theme.dart';
import 'package:flutter/material.dart';

import '../../../controllers/transactionController/transaction_controller.dart';
import '../../../utils/alert/alert_dialog.dart';
import '../../../utils/loading_alert.dart';
import '../../../utils/screen_size.dart';

class FormButtons extends StatelessWidget {
  final TextEditingController inputDescription;
  final TextEditingController inputValue;
  final int? selectCategory;
  final int? selectType;
  final DateTime selectDate;
  final int? transactionId;
  const FormButtons({
    Key? key,
    required this.inputDescription,
    required this.inputValue,
    required this.selectCategory,
    required this.selectType,
    required this.selectDate,
    this.transactionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeScreen = ScreenSizes.getScreenWidthSize(context);
    return Container(
      width: sizeScreen * 1,
      padding: EdgeInsets.all(sizeScreen * 0.005),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
              child: Text(
                'Cancelar',
                style: TextStyle(
                    color: AppTheme.secondyColor,
                    fontSize: sizeScreen * 0.047,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                // Navigator.of(context).pop();
              }),
          SizedBox(width: sizeScreen * 0.03),
          TextButton(
              child: Text(
                transactionId == null ? 'Adicionar' : 'Salvar',
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: sizeScreen * 0.047,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: AppTheme.secondyColor,
              ),
              onPressed: () {
                if (inputDescription.text.isEmpty) {
                  alertDialog(context, "Descrição está vazia!");
                  return;
                }

                if (selectCategory == null) {
                  alertDialog(context, "Sem categoria selecionada!");
                  return;
                }

                if (inputValue.text.isEmpty) {
                  alertDialog(context, "Valor está vazio!");
                  return;
                }
                FocusScope.of(context).unfocus();
                loadingDialog(context, "Adicionando transação...");
                final transaction = {
                  "description": inputDescription.text,
                  "category_id": selectCategory,
                  "value": double.tryParse(inputValue.text
                          .replaceAll(".", "")
                          .replaceAll(",", ".")) ??
                      0.0,
                  "type": selectType ?? 1,
                  "date": selectDate,
                };

                if (transactionId == null) {
                  // TransactionController.createTransaction(
                  //   context: context,
                  //   newTransaction: transaction,
                  //   onRefresh: onRefresh,
                  // );
                } else {
                  // TransactionController.updateTransaction(
                  //   context: context,
                  //   transactionId: transactionId!,
                  //   updateTransaction: transaction,
                  //   onRefresh: onRefresh,
                  // );
                }
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}
