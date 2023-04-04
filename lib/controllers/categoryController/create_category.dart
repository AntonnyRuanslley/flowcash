part of 'category_controller.dart';

void implementCreateCategory({
  required BuildContext context,
  required String categoryName,
}) async {
  loadingDialog(context, "Criando categoria...");
  final categoriesBox = Hive.box('categories');
  if (categoryName.isEmpty) {
    return;
  }
  var newCategory = ({
    "name": categoryName,
  });
  await categoriesBox.add(newCategory);
  Navigator.of(context).pop();
  Navigator.of(context).pop();
  // snackBarAlertII(
  //   context: context,
  //   message: "Categoria criada com sucesso!",
  //   backgroundColor: Colors.blueAccent,
  // );
}
