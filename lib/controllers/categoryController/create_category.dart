part of 'category_controller.dart';

void implementCreateCategory({
  required BuildContext context,
  required String categoryName,
}) async {
  final categoriesBox = Hive.box('categories');
  if (categoryName.isEmpty) {
    return;
  }
  var newCategory = ({
    "name": categoryName,
  });
  await categoriesBox.add(newCategory);
  Navigator.of(context).pop();
}
