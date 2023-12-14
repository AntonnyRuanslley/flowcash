part of 'transaction_controller.dart';

Map<String, dynamic> implementGetTransactionCalculations({
  required List<Transaction> actualTransaction,
  required List<Transaction> allTransaction,
  required DateTime selectedDate,
}) {
  final Map<String, dynamic> transactionsCalculations = {};
  transactionsCalculations
      .addAll({'recipe': recipeOrExpense(1, actualTransaction)});

  transactionsCalculations
      .addAll({'expense': recipeOrExpense(2, actualTransaction)});

  transactionsCalculations.addAll({'balance': balance(actualTransaction)});

  transactionsCalculations.addAll({
    'initialBalance': initialBalance(
      allTransaction,
      selectedDate,
    )
  });

  transactionsCalculations.addAll({
    'finalBalance': finalBalance(
      transactionsCalculations['initialBalance'],
      transactionsCalculations['balance'],
    )
  });

  return transactionsCalculations;
}

double recipeOrExpense(type, List<Transaction> actualTransaction) {
  if (actualTransaction.isEmpty) {
    return 0;
  } else {
    var listValues = actualTransaction.map((listValues) {
      if (listValues.type == type) {
        return double.parse(listValues.value.toString());
      }
    });
    return listValues
        .map((values) => (values ?? 0.0))
        .reduce((total, prox) => total + prox);
  }
}

double balance(List<Transaction> actualTransaction) {
  return recipeOrExpense(1, actualTransaction) +
      (recipeOrExpense(2, actualTransaction) * -1);
}

double initialBalance(
  List<Transaction> allTransaction,
  DateTime selectedDate,
) {
  if (allTransaction.isEmpty) {
    return 0;
  } else {
    var listValues = allTransaction.map((listValues) {
      if (listValues.date
          .isBefore(selectedDate.subtract(const Duration(days: 1)))) {
        if (listValues.type == 2) {
          return (listValues.value * -1);
        } else {
          return listValues.value;
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
