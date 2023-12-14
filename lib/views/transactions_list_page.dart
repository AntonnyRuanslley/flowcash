import 'package:flowcash/themes/app_theme.dart';
import 'package:flowcash/utils/open_form.dart';
import 'package:flowcash/views/transaction_form.dart';
import 'package:flowcash/widgets/transactionPage/transactions_list_body.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../controllers/transactionController/transaction_controller.dart';
import '../views/settings_drawer.dart';
import '../widgets/transactionPage/tableValues/table_values.dart';
import '../widgets/transactionPage/title_top.dart';
import '../widgets/transactionPage/day_flow.dart';

class TransactionsListPage extends GetView<TransactionController> {
  TransactionsListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: controller.scaffoldKey,
      backgroundColor: AppTheme.primaryColor,
      body: SafeArea(
        child: Container(
          color: Colors.grey[50],
          child: Column(
            children: [
              Stack(
                children: [
                  TitleTop(),
                  TableValues(),
                ],
              ),
              DayFlow(),
              TransactionsListBody(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryColor,
        child: Icon(Icons.add, color: AppTheme.secondyColor),
        onPressed: () => openForm(TransactionForm()),
        elevation: 8,
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      drawer: SettingsDrawer(),
    );
  }
}
