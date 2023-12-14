// ignore_for_file: invalid_use_of_protected_member

import 'package:flowcash/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/transactionController/transaction_controller.dart';
import '../../../utils/format_value.dart';
import '../../../utils/screen_size.dart';
import '../../../widgets/transactionPage/tableValues/custom_title.dart';
import '../../../widgets/transactionPage/tableValues/custom_value.dart';

class TableValues extends GetView<TransactionController> {
  TableValues({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeScreen = ScreenSizes.getScreenHeightSize(context);

    return Obx(() {
      return Padding(
        padding: EdgeInsetsDirectional.only(
          start: sizeScreen * 0.015,
          top: sizeScreen * 0.1,
          end: sizeScreen * 0.015,
          bottom: sizeScreen * 0.01,
        ),
        child: Container(
          height: controller.showFullTable.value
              ? sizeScreen * 0.3
              : sizeScreen * 0.2,
          decoration: BoxDecoration(
            color: AppTheme.secondyColor,
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
                            controller
                                .transactionsCalculations.value['balance'],
                          ),
                          label: 'Saldo',
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomValue(
                          color: Colors.green,
                          label: FormatValue.getMoneyFormat(
                            controller.transactionsCalculations.value['recipe'],
                          ),
                        ),
                        CustomValue(
                          color: Colors.red,
                          label: FormatValue.getMoneyFormat(
                            controller
                                    .transactionsCalculations.value['expense'] *
                                -1,
                          ),
                        ),
                        CustomValue(
                          color: FormatValue.getSelectColor(controller
                              .transactionsCalculations.value['balance']),
                          label: FormatValue.getMoneyFormat(
                            controller
                                .transactionsCalculations.value['balance'],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: controller.showFullTable.value,
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
                                color: FormatValue.getSelectColor(controller
                                    .transactionsCalculations
                                    .value['initialBalance']),
                                label: 'Saldo inicial',
                              ),
                              CustomTitle(
                                icon: Icons.monetization_on_sharp,
                                color: FormatValue.getSelectColor(controller
                                    .transactionsCalculations
                                    .value['finalBalance']),
                                label: 'Saldo final',
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomValue(
                                  color: FormatValue.getSelectColor(controller
                                      .transactionsCalculations
                                      .value['initialBalance']),
                                  label: FormatValue.getMoneyFormat(controller
                                      .transactionsCalculations
                                      .value['initialBalance'])),
                              CustomValue(
                                color: FormatValue.getSelectColor(controller
                                    .transactionsCalculations
                                    .value['finalBalance']),
                                label: FormatValue.getMoneyFormat(
                                  controller.transactionsCalculations
                                      .value['finalBalance'],
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
              InkWell(
                child: Icon(
                  controller.showFullTable.value
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                ),
                onTap: () => controller.showFullTable.value =
                    !controller.showFullTable.value,
              ),
            ],
          ),
        ),
      );
    });
  }
}
