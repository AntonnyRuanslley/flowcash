import 'package:flutter/material.dart';

confirmationAlertDialog({
  required BuildContext context,
  required String msgTitle,
  required String completeMsg,
  required Function() function,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(msgTitle),
        content: Text(completeMsg),
        actions: [
          TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          TextButton(
            child: const Text('Excluir'),
            onPressed: () async {
              function();
            },
          ),
        ],
      );
    },
  );
}
