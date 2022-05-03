import 'package:cas/components/transaction_form.dart';
import 'package:cas/data/dummy_transaction.dart';
import 'package:cas/models/transaction.dart';
import 'package:cas/views/home.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InformationTransaction extends StatefulWidget {
  Transaction transaction;
  final Function(String) onRemove;

  InformationTransaction(this.transaction, this.onRemove);

  @override
  State<InformationTransaction> createState() => _InformationTransactionState();
}

class _InformationTransactionState extends State<InformationTransaction> {
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
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                widget.onRemove(id);
              },
            ),
          ],
        );
      },
    );
  }

  _editTrasanction(String id, String editDescription, String editCategory,
      double editValue, int editType, DateTime editDate) {
    for (var tr in DUMMY_TRANSACTION) {
      if (tr.id == id) {
        setState(() {
          tr.description = editDescription;
          tr.category = editCategory;
          tr.value = editValue;
          tr.type = editType;
          tr.status = 1;
          tr.date = editDate;
        });

        /*Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  InformationTransaction(widget.transaction, widget.onRemove)),
        ).then((_) => setState(() {}));*/

        //widget.onRefresh;
        Navigator.of(context)
            .push(new MaterialPageRoute(builder: (BuildContext context) {
          return new Home();
        }));
      }
    }
  }

  _openForm(context, String id, String description, String category,
      double value, int type, DateTime date) {
    showDialog(
        context: context,
        builder: (context) {
          return TransactionForm(_editTrasanction, false, id, description,
              category, value, type, date);
        });
  }

  @override
  Widget build(BuildContext context) {
    final sizeSreen = MediaQuery.of(context).size.width;

    _information(String title, content) {
      return Container(
        height: sizeSreen * 0.15,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: sizeSreen * 0.051,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Text(
              content,
              style: TextStyle(
                fontSize: sizeSreen * 0.051,
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
        height: sizeSreen * 0.9,
        width: sizeSreen * 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _information("Descrição", widget.transaction.description),
            _information("Categoria", widget.transaction.category),
            _information(
                "Tipo", widget.transaction.type == 1 ? "Receita" : "Despesa"),
            _information(
                "Valor",
                NumberFormat('R\$ #.00', 'pt-BR')
                    .format(widget.transaction.value)),
            _information(
                "Data da transação",
                DateFormat('dd/MM/yy', 'pt-BR')
                    .format(widget.transaction.date)),
            _information("Status",
                widget.transaction.status == 1 ? "Pendente" : "Aprovado"),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(
              left: sizeSreen * 0.03,
              right: sizeSreen * 0.03,
              bottom: sizeSreen * 0.03),
          child: SizedBox(
            width: sizeSreen * 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text(
                    'Excluir',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: sizeSreen * 0.051,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => _openAlert(context, widget.transaction.id),
                ),
                SizedBox(width: sizeSreen * 0.03),
                TextButton(
                  child: Text(
                    'Editar',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: sizeSreen * 0.051,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => _openForm(
                      context,
                      widget.transaction.id,
                      widget.transaction.description,
                      widget.transaction.category,
                      widget.transaction.value,
                      widget.transaction.type,
                      widget.transaction.date),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
