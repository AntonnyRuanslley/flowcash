import '../models/transaction.dart';

import 'package:flutter/material.dart';

class Status extends StatelessWidget {
  final Iterable<Transaction> transaction;

  Status(this.transaction);
  @override
  Widget build(BuildContext context) {
    _pendentOrOk(int status) {
      if (transaction.isEmpty) {
        return 0;
      } else {
        var listSize = transaction.map((listSize) {
          if (listSize.status == status) {
            return 1;
          }
        });
        return listSize
            .map((values) => (values ?? 0))
            .reduce((total, prox) => total + prox);
      }
    }

    _pendents() {
      return _pendentOrOk(1) == 1 ? 'Pendente' : 'Pendentes';
    }

    _ok() {
      return _pendentOrOk(2) == 1 ? 'Aprovado' : 'Aprovados';
    }

    return Padding(
      padding:
          EdgeInsetsDirectional.only(start: 17, top: 4, end: 17, bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Status',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${_pendentOrOk(1)} ${_pendents()} ${_pendentOrOk(2)} ${_ok()}',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
