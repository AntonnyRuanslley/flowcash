import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/format_value.dart';
import '../../utils/open_form.dart';
import '../../utils/screen_size.dart';
import '../../models/transaction.dart';
import '../../themes/app_theme.dart';
import '../../controllers/categoryController/category_controller.dart';
import '../../views/transaction_information.dart';

class TransactionTile extends GetView<CategoryController> {
  final Transaction transaction;

  const TransactionTile({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final sizeScreen = ScreenSizes.getScreenHeightSize(context);

    transaction.category.name = controller.searchCategory(
      transaction.category.id,
    );

    return TextButton(
      onPressed: () => openForm(
        TransactionInformation(
          transaction: transaction,
        ),
      ),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            color: AppTheme.secondyColor,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              const BoxShadow(
                color: Color.fromARGB(255, 213, 210, 210),
                offset: Offset(1, 1),
                blurRadius: 3,
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 20,
            child: Icon(
              transaction.type == 1
                  ? Icons.arrow_downward_rounded
                  : Icons.arrow_upward_rounded,
              color: FormatValue.banlaceOrExpanse(transaction.type),
            ),
            backgroundColor: AppTheme.secondyColor,
          ),
        ),
        title: Text(
          transaction.description,
          style: TextStyle(
            fontSize: sizeScreen * 0.025,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Text(
          controller.searchCategory(transaction.category.id),
          style: TextStyle(
            fontSize: sizeScreen * 0.027,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: SizedBox(
          width: sizeScreen * 0.21,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                FormatValue.getMoneyFormat(transaction.type == 1
                    ? transaction.value
                    : transaction.value * -1),
                style: TextStyle(
                  color: FormatValue.banlaceOrExpanse(transaction.type),
                  fontSize: sizeScreen * 0.027,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
