import 'package:cas/data/categories.dart';
import '../../views/transaction_information.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionsTile extends StatefulWidget {
  final transaction;
  final Function onRefresh;

  TransactionsTile(this.transaction, this.onRefresh);

  @override
  State<TransactionsTile> createState() => _TransactionsTileState();
}

class _TransactionsTileState extends State<TransactionsTile> {
  bool? _banlacePos(type) {
    if (type == 1) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    _searchCategory(id) {
      for (var category in categories) {
        if (id == category['id']) {
          return category['name'];
        }
      }
      return "Sem categoria";
    }

    _openInformation(category) {
      setState(() {
        showDialog(
            context: context,
            builder: (context) {
              return TransactionInformation(
                  widget.transaction, category, widget.onRefresh);
            });
      });
    }

    return TextButton(
      onPressed: () => _openInformation(
          _searchCategory(widget.transaction['category_id']).toString()),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              const BoxShadow(
                color: Color.fromARGB(255, 213, 210, 210),
                offset: Offset(1, 1),
                blurRadius: 3,
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 20,
            child: Icon(
              _banlacePos(widget.transaction['type'])!
                  ? Icons.arrow_downward_rounded
                  : Icons.arrow_upward_rounded,
              color: _banlacePos(widget.transaction['type'])!
                  ? Colors.green
                  : Colors.red,
            ),
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
        ),
        title: Text(
          widget.transaction['description'],
          style: TextStyle(
            fontSize: sizeScreen * 0.025,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Text(
          _searchCategory(widget.transaction['category_id']).toString(),
          style: TextStyle(
            fontSize: sizeScreen * 0.027,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: SizedBox(
          width: sizeScreen * 0.21,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                NumberFormat(' R\$ #.00', 'pt-BR').format(
                    widget.transaction['type'] == 1
                        ? widget.transaction['value']
                        : widget.transaction['value'] * -1),
                style: TextStyle(
                  color: _banlacePos(widget.transaction['type'])!
                      ? Colors.green
                      : Colors.red,
                  fontSize: sizeScreen * 0.027,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
