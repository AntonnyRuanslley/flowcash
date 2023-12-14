import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../utils/format_value.dart';
import '../themes/app_theme.dart';
import '../models/transaction.dart';
import '../controllers/categoryController/category_controller.dart';
import '../widgets/transactionInformationPage/information_buttons_options.dart';
import '../widgets/transactionInformationPage/information_tile.dart';

class TransactionInformation extends GetView<CategoryController> {
  final Transaction transaction;

  const TransactionInformation({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppTheme.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        "Informações",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppTheme.secondyColor,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InformationTile(
              title: "Descrição",
              content: transaction.description,
            ),
            InformationTile(
              title: "Categoria",
              content: transaction.category.name!,
            ),
            InformationTile(
              title: "Tipo",
              content: transaction.type == 1 ? "Receita" : "Despesa",
            ),
            InformationTile(
              title: "Valor",
              content: FormatValue.getMoneyFormat(transaction.value),
            ),
            InformationTile(
              title: "Data da transação",
              content: DateFormat('dd/MM/yy', 'pt-BR').format(transaction.date),
            ),
          ],
        ),
      ),
      actions: [
        InformationButtonsOptions(transaction: transaction),
      ],
    );
  }
}
