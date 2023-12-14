part of 'category_controller.dart';

void implementCreateCategory({
  required String categoryName,
}) async {
  loadingDialog(msg: "Criando categoria...");
  final categoriesBox = Hive.box('categories');
  if (categoryName.isEmpty) {
    return;
  }
  var newCategory = ({
    "name": categoryName,
  });
  await categoriesBox.add(newCategory);
  Get.find<CategoryController>().refresh();

  Get.back();
  Get.back();
  Get.showSnackbar(Ui.successSnackBar(message: "Categoria criada!"));
}
