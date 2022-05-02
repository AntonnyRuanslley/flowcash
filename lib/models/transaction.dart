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
}
