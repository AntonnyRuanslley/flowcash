class Transaction {
  final String id;
  final String category;
  final String description;
  final DateTime date;
  final String status;
  final double value;
  final int type;

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
