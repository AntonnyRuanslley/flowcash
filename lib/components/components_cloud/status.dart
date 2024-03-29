import 'package:flutter/material.dart';

class Status extends StatelessWidget {
  final List transaction;

  Status(this.transaction);
  @override
  Widget build(BuildContext context) {
    var sizeScreen = MediaQuery.of(context).size.height;

    _pendentOrOk(int status) {
      if (transaction.isEmpty) {
        return 0;
      } else {
        var listSize = transaction.map((listSize) {
          if (listSize['status'] == status) {
            return 1;
          }
        });
        return listSize
            .map((values) => (values ?? 0))
            .reduce((total, prox) => total + prox);
      }
    }

    _pendent() {
      return _pendentOrOk(1) == 1 ? 'Pendente' : 'Pendentes';
    }

    _ok() {
      return _pendentOrOk(2) == 1 ? 'Aprovado' : 'Aprovados';
    }

    return Padding(
      padding: EdgeInsetsDirectional.only(
          start: sizeScreen * 0.03,
          top: sizeScreen * 0.01,
          end: sizeScreen * 0.03,
          bottom: sizeScreen * 0.01),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Status',
            style: TextStyle(
              fontSize: sizeScreen * 0.027,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${_pendentOrOk(1)} ${_pendent()} ${_pendentOrOk(2)} ${_ok()}',
            style: TextStyle(
              fontSize: sizeScreen * 0.027,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
