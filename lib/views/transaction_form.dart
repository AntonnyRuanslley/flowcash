import 'package:cas/components/components_local/category_widgets/categorys_file.dart';
import 'package:cas/themes/app_theme.dart';
import 'package:cas/utils/format_value.dart';
import 'package:cas/utils/open_form.dart';
import 'package:cas/utils/screen_size.dart';
import 'package:cas/widgets/transactionForm/select_transaction_type.dart';
import 'package:cas/components/components_local/category_widgets/category_add.dart';
import 'package:cas/utils/select_date_modal.dart';
import 'package:cas/widgets/transactionForm/form_buttons.dart';
import 'package:cas/widgets/transactionForm/select_date.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:cas/widgets/transactionForm/custom_text_field.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final Map<String, dynamic>? transaction;
  final String? category;
  final Function() onRefresh;

  const TransactionForm({
    Key? key,
    this.transaction,
    this.category,
    required this.onRefresh,
  }) : super(key: key);

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
  initState() {
    super.initState();
    if (widget.transaction != null) {
      inputDescription.text = widget.transaction!['description'];
      selectCategory = widget.transaction!['category_id'];
      inputValue.text =
          FormatValue.getMoneyFormatNoFigures(widget.transaction!['value']);
      selectType = widget.transaction!['type'];
      selectDate = DateTime.parse(widget.transaction!['date'].toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = ScreenSizes.getScreenWidthSize(context);

    return SingleChildScrollView(
      child: AlertDialog(
        scrollable: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          widget.transaction == null ? "Nova transação" : "Edição de transação",
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
                Row(
                  children: [
                    InkWell(
                      child: Icon(
                        Icons.add_circle_outline_rounded,
                        color: AppTheme.secondyColor,
                        size: sizeScreen * 0.07,
                      ),
                      onTap: () => openForm(context, CategoryForm()),
                    ),
                    SizedBox(width: sizeScreen * 0.05),
                    Expanded(
                      child: CategorysFile(
                        onSubmit: (int category) {
                          setState(() {
                            selectCategory = category;
                          });
                        },
                        category: widget.category,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "R\$",
                      style: TextStyle(
                          color: Colors.white, fontSize: sizeScreen * 0.06),
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
                    type: widget.transaction?['type'],
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
                  onRefresh: widget.onRefresh,
                  transactionId: widget.transaction?['id'],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
