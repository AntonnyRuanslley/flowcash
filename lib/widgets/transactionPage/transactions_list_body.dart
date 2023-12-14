// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/screen_size.dart';
import '../../themes/app_theme.dart';
import '../../controllers/transactionController/transaction_controller.dart';
import '../../widgets/transactionPage/transactions_tile.dart';
import '../../widgets/custom/empty_list.dart';

class TransactionsListBody extends GetView<TransactionController> {
  const TransactionsListBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenSizes.getScreenHeightSize(context);
    return Obx(() {
      return Expanded(
        child: controller.dayTransactions.isEmpty
            ? EmptyList(
                fontSize: screenSize * 0.05,
                imageSize: screenSize * 0.25,
                color: AppTheme.primaryText,
              )
            : ListView.builder(
                itemCount: controller.dayTransactions.length,
                itemBuilder: (ctx, i) {
                  return TransactionTile(
                    transaction: controller.dayTransactions.value[i],
                  );
                },
              ),
      );
    });
  }
}
