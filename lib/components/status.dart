import '../models/transaction.dart';

import 'package:flutter/material.dart';

class Status extends StatelessWidget {
  final Iterable<Transaction> transaction;

  Status(this.transaction);
  @override
  Widget build(BuildContext context) {
    _pendentOrOk(int status) {
      var listSize = transaction.map((listSize) {
        if (listSize.status == status) {
          return 1;
        }
      });
      return listSize
          .map((values) => (values ?? 0))
          .reduce((total, prox) => total + prox);
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
            '${_pendentOrOk(1)} Pendentes ${_pendentOrOk(2)} Aprovados',
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
