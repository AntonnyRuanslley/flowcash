class Transaction {
  String id;
  String categoryId;
  String description;
  DateTime date;
  int? status;
  double value;
  int type;

  Transaction({
    required this.id,
    required this.categoryId,
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
      categoryId: data['category_id'],
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
      'category_id': categoryId,
      'description': description,
      'date': date,
      'status': status,
      'value': value,
      'type': type,
    };
    return map;
  }
}
