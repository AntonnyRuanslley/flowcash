import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

import '../themes/app_theme.dart';
import '../models/transaction.dart';
import '../utils/format_value.dart';
import '../utils/open_form.dart';
import '../utils/screen_size.dart';
import '../utils/select_date_modal.dart';
import '../widgets/transactionForm/select_transaction_type.dart';
import '../views/category_form.dart';
import '../widgets/transactionForm/categorys_select.dart';
import '../widgets/transactionForm/form_buttons.dart';
import '../widgets/transactionForm/select_date.dart';
import '../widgets/transactionForm/custom_text_field.dart';

class TransactionForm extends StatefulWidget {
  final Transaction? transaction;

  const TransactionForm({
    super.key,
    this.transaction,
  });

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final inputDescription = TextEditingController();
  final inputValue = TextEditingController();
  int? selectCategory;
  int? selectType;
  DateTime selectDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.transaction != null) {
      inputDescription.text = widget.transaction!.description;
      selectCategory = widget.transaction!.category.id;
      inputValue.text =
          FormatValue.getMoneyFormatNoFigures(widget.transaction!.value);
      selectType = widget.transaction!.type;
      selectDate = widget.transaction!.date;
    }
  }

  @override
  void dispose() {
    super.dispose();
    inputDescription.dispose();
    inputValue.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = ScreenSizes.getScreenWidthSize(context);

    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: AlertDialog(
          scrollable: true,
          backgroundColor: AppTheme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            widget.transaction == null
                ? "Nova transação"
                : "Edição de transação",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.secondyColor,
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
                  Row(
                    children: [
                      InkWell(
                        child: Icon(
                          Icons.add_circle_outline_rounded,
                          color: AppTheme.secondyColor,
                          size: sizeScreen * 0.07,
                        ),
                        onTap: () => openForm(CategoryForm()),
                      ),
                      SizedBox(width: sizeScreen * 0.05),
                      Expanded(
                        child: CategorysSelect(
                          onSubmit: (int category) {
                            setState(() {
                              selectCategory = category;
                            });
                          },
                          categoryId: selectCategory,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "R\$",
                        style: TextStyle(
                          color: AppTheme.secondyColor,
                          fontSize: sizeScreen * 0.06,
                        ),
                      ),
                      SizedBox(width: sizeScreen * 0.05),
                      Expanded(
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
                    child: SelectTransactionType(
                      onSubmit: (int type) {
                        setState(() {
                          selectType = type;
                        });
                      },
                      type: selectType,
                    ),
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
                    transactionId: widget.transaction?.id,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
