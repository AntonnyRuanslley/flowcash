part of 'category_controller.dart';

void implementGetCategories() {
  final categoriesBox = Hive.box('categories');
  final data = categoriesBox.keys.map((key) {
    final value = categoriesBox.get(key);
    return {
      "id": key,
      "name": value["name"],
    };
  }).toList();
  categories = data.reversed.toList();
}
