import 'package:flutter/material.dart';

final transactionAdded = SnackBar(
  content: Text(
    "Nova transação adicionada com sucesso!",
    textAlign: TextAlign.center,
  ),
  backgroundColor: Colors.blueAccent,
);

final transactionEditted = SnackBar(
  content: Text(
    "Transação editada com sucesso!",
    textAlign: TextAlign.center,
  ),
  backgroundColor: Colors.blueAccent,
);

final transactionExcluded = SnackBar(
  content: Text(
    "Transação excluída com sucesso!",
    textAlign: TextAlign.center,
  ),
  backgroundColor: Colors.redAccent,
);

final userAdded = SnackBar(
  content: Text(
    "Novo usuário cadastrado com sucesso!",
    textAlign: TextAlign.center,
  ),
  backgroundColor: Colors.blueAccent,
);

final userEditted = SnackBar(
    content: Text(
      "Usuário editado com sucesso!",
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.blueAccent,
  );

final userExcluded = SnackBar(
    content: Text(
      "Usuário excluído com sucesso!",
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.redAccent,
  );
