import 'package:cas/data/dummy_transaction.dart';
import 'package:cas/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InformationTransaction extends StatelessWidget {
  Transaction transaction;
  final Function(String) onRemove;

  InformationTransaction(this.transaction, this.onRemove);

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
                onRemove(id);
              },
            ),
          ],
        );
      },
    );
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
        height: sizeSreen * 0.75,
        width: sizeSreen * 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _information("Descrição", transaction.description),
            _information("Categoria", transaction.category),
            _information("Tipo", transaction.type == 1 ? "Receita" : "Despesa"),
            _information(
                "Valor",
                NumberFormat('R\$ #.00', 'pt-BR').format(transaction.type == 1
                    ? transaction.value
                    : (transaction.value * -1))),
            _information("Data da transação",
                DateFormat('dd/MM/yy', 'pt-BR').format(transaction.date)),
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
                  onPressed: () => _openAlert(context, transaction.id),
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
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
