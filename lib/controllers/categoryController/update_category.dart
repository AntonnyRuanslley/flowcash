part of 'category_controller.dart';

void implementUpdateCategory({
  required BuildContext context,
  required String categoryName,
  required int categoryId,
  required Function() onRefresh,
}) async {
  final categoriesBox = Hive.box('categories');
  var newCategory = ({
    "name": categoryName,
  });
  await categoriesBox.put(categoryId, newCategory);
  onRefresh();
  Navigator.of(context).pop();
}
