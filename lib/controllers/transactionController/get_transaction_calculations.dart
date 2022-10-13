part of 'transaction_controller.dart';

Map<String, dynamic> implementGetTransactionCalculations({
  required List<dynamic> actualTransaction,
  required List<dynamic> allTransaction,
}) {
  final Map<String, dynamic> transactionsCalculations = {};

  transactionsCalculations
      .addAll({'recipe': recipeOrExpense(1, actualTransaction)});

  transactionsCalculations
      .addAll({'expense': recipeOrExpense(2, actualTransaction)});

  transactionsCalculations.addAll({'balance': balance(actualTransaction)});

  transactionsCalculations
      .addAll({'initialBalance': initialBalance(allTransaction)});

  transactionsCalculations.addAll({
    'finalBalance': finalBalance(
      transactionsCalculations['initialBalance'],
      transactionsCalculations['balance'],
    )
  });

  return transactionsCalculations;
}

double recipeOrExpense(type, List<dynamic> actualTransaction) {
  if (actualTransaction.isEmpty) {
    return 0;
  } else {
    var listValues = actualTransaction.map((listValues) {
      if (listValues['type'] == type) {
        return double.parse(listValues['value'].toString());
      }
    });
    return listValues
        .map((values) => (values ?? 0.0))
        .reduce((total, prox) => total + prox);
  }
}

double balance(List<dynamic> actualTransaction) {
  return recipeOrExpense(1, actualTransaction) +
      (recipeOrExpense(2, actualTransaction) * -1);
}

double initialBalance(List<dynamic> allTransaction) {
  if (allTransaction.isEmpty) {
    return 0;
  } else {
    var listValues = allTransaction.map((listValues) {
      if (DateTime.parse(listValues['date'].toString())
          .isBefore(selectDate.subtract(const Duration(days: 1)))) {
        if (listValues['type'] == 2) {
          return (double.parse(listValues['value'].toString()) * -1);
        } else {
          return double.parse(listValues['value'].toString());
        }
      }
    });
    return listValues
        .map((values) => (values ?? 0.0))
        .reduce((total, prox) => total + prox);
  }
}

finalBalance(double initialBalance, double balance) {
  return initialBalance + balance;
}
