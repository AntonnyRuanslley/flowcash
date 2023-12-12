part of 'category_controller.dart';

void implementUpdateCategory({
  required BuildContext context,
  required String categoryName,
  required int categoryId,
}) async {
  final categoriesBox = Hive.box('categories');
  var newCategory = ({
    "name": categoryName,
  });
  await categoriesBox.put(categoryId, newCategory);
  Navigator.of(context).pop();
}
