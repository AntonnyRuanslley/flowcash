class Category {
  final int id;
  String? name;

  Category({
    required this.id,
    this.name,
  });

  factory Category.setCategoryModel({
    required Map<String, dynamic> json,
  }) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}
