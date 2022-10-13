import 'package:cas/components/components_local/category_widgets/categorys_file.dart';
import 'package:cas/widgets/transactionForm/select_transaction_type.dart';
import 'package:cas/components/components_local/category_widgets/category_add.dart';
import 'package:cas/controllers/transactionController/transaction_controller.dart';
import 'package:cas/utils/select_date_modal.dart';
import 'package:cas/widgets/transactionForm/form_buttons.dart';
import 'package:cas/widgets/transactionForm/select_date.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:cas/widgets/transactionForm/custom_text_field.dart';
import 'package:flutter/material.dart';

class TransactionAdd extends StatefulWidget {
  final Function() onRefresh;

  const TransactionAdd({
    Key? key,
    required this.onRefresh,
  }) : super(key: key);

  @override
  State<TransactionAdd> createState() => _TransactionAddState();
}

class _TransactionAddState extends State<TransactionAdd> {
  final inputDescription = TextEditingController();
  final inputValue = TextEditingController();
  int? selectCategory;
  int? selectType;
  DateTime selectDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: AlertDialog(
        scrollable: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          "Nova transação",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        content: SizedBox(
          height: sizeScreen * 1.2,
          child: Padding(
            padding: EdgeInsets.all(sizeScreen * 0.01),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextField(
                  hintText: "Descrição",
                  controller: inputDescription,
                  keyboardType: TextInputType.name,
                ),
                CategorysFile(_addCategory, false),
                Row(
                  children: [
                    Text(
                      "  R\$  ",
                      style: TextStyle(
                          color: Colors.white, fontSize: sizeScreen * 0.06),
                    ),
                    Flexible(
                      child: CustomTextField(
                        hintText: "0,00",
                        controller: inputValue,
                        keyboardType: TextInputType.numberWithOptions(),
                        inputFormatters: [
                          CurrencyTextInputFormatter(
                            locale: 'pt',
                            decimalDigits: 2,
                            symbol: '',
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: sizeScreen * 0.28,
                  child: SelectTransactionType(onSubmit: _addType, isAdd: true),
                ),
                SelectDate(
                  selectDate: selectDate,
                  onPressed: () => selectDateModal(
                    context: context,
                    oldDate: selectDate,
                    selectedDate: (newDate) {
                      setState(() {
                        selectDate = newDate;
                      });
                    },
                  ),
                ),
                FormButtons(
                  inputDescription: inputDescription,
                  inputValue: inputValue,
                  selectCategory: selectCategory,
                  selectType: selectType,
                  selectDate: selectDate,
                  onRefresh: widget.onRefresh,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // _openCategoryFormModal(BuildContext context) {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return CategoryForm();
  //       });
  // }

  _addCategory(int category) {
    setState(() {
      selectCategory = category;
    });
  }

  _addType(int type) {
    setState(() {
      selectType = type;
    });
  }
}
