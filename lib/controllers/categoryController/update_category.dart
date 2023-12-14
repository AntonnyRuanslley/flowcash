part of 'category_controller.dart';

void implementUpdateCategory({
  required String categoryName,
  required int categoryId,
}) async {
  final categoriesBox = Hive.box('categories');
  var newCategory = ({
    "name": categoryName,
  });
  loadingDialog(msg: "Atualizando categoria...");
  await categoriesBox.put(categoryId, newCategory);
  Get.find<CategoryController>().refresh();
  Get.back();
  Get.back();

  Get.showSnackbar(
    Ui.successSnackBar(message: "Categoria atualizada!"),
  );
}
