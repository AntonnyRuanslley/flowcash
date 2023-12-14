import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/alert/alert_dialog.dart';
import '../../utils/loading_alert.dart';
import '../../utils/screen_size.dart';
import '../../themes/app_theme.dart';
import '../../controllers/transactionController/transaction_controller.dart';

class FormButtons extends GetView<TransactionController> {
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
            onPressed: () => Get.back(),
          ),
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
                  alertDialog(title: "Descrição está vazia!");
                  return;
                }

                if (selectCategory == null) {
                  alertDialog(title: "Sem categoria selecionada!");
                  return;
                }

                if (inputValue.text.isEmpty) {
                  alertDialog(title: "Valor está vazio!");
                  return;
                }
                loadingDialog(msg: "Adicionando transação...");
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
                  controller.createTransaction(newTransaction: transaction);
                } else {
                  controller.updateTransaction(
                    transactionId: transactionId!,
                    updateTransaction: transaction,
                  );
                }
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}
