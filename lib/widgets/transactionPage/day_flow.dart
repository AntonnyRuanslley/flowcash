import 'package:flowcash/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../utils/screen_size.dart';
import '../../utils/select_date_modal.dart';
import '../../controllers/transactionController/transaction_controller.dart';

class DayFlow extends GetView<TransactionController> {
  DayFlow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeScreen = ScreenSizes.getScreenHeightSize(context);

    return Obx(() {
      return Container(
        height: sizeScreen * 0.055,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: sizeScreen * 0.033,
              ),
              onPressed: controller.selectedDate.value
                      .subtract(const Duration(days: 1))
                      .isBefore(DateTime(2000))
                  ? null
                  : () {
                      controller.setDate(
                        controller.selectedDate.value
                            .subtract(const Duration(days: 1)),
                      );
                    },
            ),
            Expanded(
              child: Container(
                child: TextButton(
                  child: Text(
                    DateFormat("dd 'de' MMMM 'de' yyy", "pt_BR")
                        .format(controller.selectedDate.value),
                    style: TextStyle(
                      fontSize: sizeScreen * 0.028,
                      color: AppTheme.primaryText,
                    ),
                  ),
                  onPressed: () => selectDateModal(
                    context: context,
                    oldDate: controller.selectedDate.value,
                    selectedDate: controller.setDate,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_forward_ios_rounded,
                size: sizeScreen * 0.033,
              ),
              onPressed: controller.selectedDate.value
                      .add(const Duration(days: 1))
                      .isAfter(DateTime.now())
                  ? null
                  : () {
                      controller.setDate(controller.selectedDate.value
                          .add(const Duration(days: 1)));
                    },
            ),
          ],
        ),
      );
    });
  }
}
