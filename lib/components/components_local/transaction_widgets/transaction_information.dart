import 'package:cas/components/components_local/transaction_widgets/transaction_edit.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class TransactionInformation extends StatefulWidget {
  final transaction;
  final category;
  final Function onRefresh;

  TransactionInformation(this.transaction, this.category, this.onRefresh);

  @override
  State<TransactionInformation> createState() => _TransactionInformationState();
}

class _TransactionInformationState extends State<TransactionInformation> {
  final _transactionsBox = Hive.box('transactions');

  final message = SnackBar(
    content: Text(
      "Transação excluida com sucesso",
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.redAccent,
  );

  Future<void> _deleteTransanction(id) async {
    await _transactionsBox.delete(id);
  }

  _onRefresh() {
    setState(() {
      widget.onRefresh();
    });
  }

  _openAlert(context, id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deseja realmente excluir?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const [
                Text('A transação será excluída permanentemente!'),
              ],
            ),
          ),
          actions: [
            TextButton(
                child: const Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            TextButton(
              child: const Text('Excluir'),
              onPressed: () async {
                _deleteTransanction(id);
                widget.onRefresh();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(message);
              },
            ),
          ],
        );
      },
    );
  }

  _openForm(context) {
    showDialog(
        context: context,
        builder: (context) {
          return TransactionEdit(
              widget.transaction, widget.category, _onRefresh);
        });
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size.width;

    _information(String title, content) {
      return Container(
        height: sizeScreen * 0.15,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: sizeScreen * 0.051,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Text(
              content,
              style: TextStyle(
                fontSize: sizeScreen * 0.051,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      );
    }

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
      content: SizedBox(
        height: sizeScreen * 0.75,
        width: sizeScreen * 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _information("Descrição", widget.transaction['description']),
            _information("Categoria", widget.category.toString()),
            _information("Tipo",
                widget.transaction['type'] == 1 ? "Receita" : "Despesa"),
            _information(
                "Valor",
                NumberFormat('R\$ #.00', 'pt-BR')
                    .format(widget.transaction['value'])),
            _information(
                "Data da transação",
                DateFormat('dd/MM/yy', 'pt-BR')
                    .format(widget.transaction['date']))
          ],
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(
              left: sizeScreen * 0.03,
              right: sizeScreen * 0.03,
              bottom: sizeScreen * 0.03),
          child: SizedBox(
            width: sizeScreen * 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text(
                    'Excluir',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: sizeScreen * 0.051,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () =>
                      _openAlert(context, widget.transaction['id']),
                ),
                SizedBox(width: sizeScreen * 0.03),
                TextButton(
                  child: Text(
                    'Editar',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: sizeScreen * 0.051,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => _openForm(context),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
