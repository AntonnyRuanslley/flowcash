import '../models/transaction.dart';

final List<Transaction> DUMMY_TRANSACTION = [
  Transaction(
      id: 'T1',
      category: 'Salário',
      description: 'Salário de Antonny',
      date: DateTime.now(),
      status: 1,
      type: 2,
      value: -1200.00),
  Transaction(
      id: 'T2',
      category: 'Conta',
      description: 'Conta de Luz',
      date: DateTime.now(),
      status: 1,
      type: 2,
      value: -500.00),
  Transaction(
      id: 'T3',
      category: 'Salário',
      description: 'Salário de Jonathan',
      date: DateTime.now(),
      status: 1,
      type: 2,
      value: -900.00),
  Transaction(
      id: 'T4',
      category: 'Pagamento',
      description: 'Pagamento pelo sistema',
      date: DateTime.now(),
      status: 2,
      type: 1,
      value: 3000.00),
];
