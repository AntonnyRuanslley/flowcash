part of 'category_controller.dart';

void implementDeleteCategory({
  required BuildContext context,
  required int categoryId,
  required Function() onRefresh,
}) async {
  loadingDialog(context, "Deletando categoria...");
  final categoriesBox = Hive.box('categories');
  await categoriesBox.delete(categoryId);
  Navigator.of(context).pop();
  onRefresh();
  Navigator.of(context).pop();
  alertDialog(context, "Categoria deletada!");
}
