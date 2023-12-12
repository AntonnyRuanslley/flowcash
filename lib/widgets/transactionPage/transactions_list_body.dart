// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/screen_size.dart';
import '../../controllers/transactionController/transaction_controller.dart';
import '../../widgets/transactionPage/transactions_tile.dart';

class TransactionsListBody extends GetView<TransactionController> {
  const TransactionsListBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Expanded(
        child: controller.dayTransactions.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: ScreenSizes.getScreenHeightSize(context) * 0.25,
                    child: const Image(
                      image: AssetImage(
                        'assets/images/vazio.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      'Sem transações!',
                      style: TextStyle(
                        fontSize:
                            ScreenSizes.getScreenHeightSize(context) * 0.05,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              )
            : ListView.builder(
                itemCount: controller.dayTransactions.length,
                itemBuilder: (ctx, i) {
                  return TransactionsTile(
                    transaction: controller.dayTransactions.value[i],
                  );
                },
              ),
      );
    });
  }
}
