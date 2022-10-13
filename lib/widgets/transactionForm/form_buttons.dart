import 'package:cas/controllers/transactionController/transaction_controller.dart';
import 'package:cas/utils/screen_size.dart';
import 'package:flutter/material.dart';

class FormButtons extends StatelessWidget {
  final TextEditingController inputDescription;
  final TextEditingController inputValue;
  final int? selectCategory;
  final int? selectType;
  final DateTime selectDate;
  final Function() onRefresh;
  const FormButtons({
    Key? key,
    required this.inputDescription,
    required this.inputValue,
    required this.selectCategory,
    required this.selectType,
    required this.selectDate,
    required this.onRefresh,
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
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: sizeScreen * 0.047,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          SizedBox(width: sizeScreen * 0.03),
          TextButton(
              child: Text(
                'Adicionar',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: sizeScreen * 0.047,
                    fontWeight: FontWeight.bold),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {
                final newTransaction = {
                  "description": inputDescription.text,
                  "category_id": selectCategory,
                  "value":
                      double.tryParse(inputValue.text.replaceAll(",", ".")) ??
                          0.0,
                  "type": selectType ?? 1,
                  "date": selectDate,
                };
                TransactionController.newTransaction(
                  context: context,
                  newTransaction: newTransaction,
                  onRefresh: onRefresh,
                );
              }),
        ],
      ),
    );
  }
}
