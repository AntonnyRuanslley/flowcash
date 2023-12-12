import 'package:flowcash/models/category.dart';

class Transaction {
  String id;
  Category category;
  String description;
  DateTime date;
  int? status;
  double value;
  int type;

  Transaction({
    required this.id,
    required this.category,
    required this.description,
    required this.date,
    this.status,
    required this.type,
    required this.value,
  });

  factory Transaction.setTransactionModel({
    required Map<String, dynamic> data,
  }) {
    return Transaction(
      id: data['id'],
      category: Category(id: data['category_id']),
      description: data['description'],
      date: data['date'],
      // status: data['status'],
      type: data['type'],
      value: data['value'],
    );
  }

  Map<String, dynamic> toMap() {
    var map = {
      'id': id,
      'category_id': category.id,
      'description': description,
      'date': date,
      'status': status,
      'value': value,
      'type': type,
    };
    return map;
  }
}
