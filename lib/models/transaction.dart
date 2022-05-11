class Transaction {
  String id;
  String category;
  String description;
  DateTime date;
  int status;
  double value;
  int type;

  Transaction({
    required this.id,
    required this.category,
    required this.description,
    required this.date,
    required this.status,
    required this.type,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    var map = {
      'id': id,
      'category': category,
      'description': description,
      'date': date,
      'status': status,
      'value': value,
      'type': type,
    };
    return map;
  }

  /*Transaction.fromMap(map) {
    id = map['id'];
    category = map['category'];
    description = map['description'];
    date = map['date'];
    status = map['status'];
    value = map['value'];
    type = map['type'];
  }*/
}
