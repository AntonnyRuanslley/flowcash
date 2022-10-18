import 'package:cas/utils/format_value.dart';
import 'package:cas/utils/screen_size.dart';
import 'package:cas/widgets/transactionInformationPage/information_buttons_options.dart';
import 'package:cas/widgets/transactionInformationPage/information_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionInformation extends StatefulWidget {
  final transaction;
  final category;
  final Function() onRefresh;

  const TransactionInformation({
    Key? key,
    required this.transaction,
    required this.category,
    required this.onRefresh,
  }) : super(key: key);

  @override
  State<TransactionInformation> createState() => _TransactionInformationState();
}

class _TransactionInformationState extends State<TransactionInformation> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        "Informações",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InformationTile(
              title: "Descrição",
              content: widget.transaction['description'],
            ),
            InformationTile(
              title: "Categoria",
              content: widget.category.toString(),
            ),
            InformationTile(
              title: "Tipo",
              content: widget.transaction['type'] == 1 ? "Receita" : "Despesa",
            ),
            InformationTile(
              title: "Valor",
              content: FormatValue.getMoneyFormat(widget.transaction['value']),
            ),
            InformationTile(
              title: "Data da transação",
              content: DateFormat('dd/MM/yy', 'pt-BR')
                  .format(widget.transaction['date']),
            ),
          ],
        ),
      ),
      actions: [
        InformationButtonsOptions(
          transaction: widget.transaction,
          onRefresh: widget.onRefresh,
        ),
      ],
    );
  }
}
