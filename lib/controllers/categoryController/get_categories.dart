part of 'category_controller.dart';

List<Category> implementGetCategories() {
  final categoriesBox = Hive.box('categories');

  final data = categoriesBox.keys.map((key) {
    final value = categoriesBox.get(key);

    return Category.setCategoryModel(json: {
      "id": key,
      "name": value["name"],
    });
  }).toList();

  return data.reversed.toList();
}
