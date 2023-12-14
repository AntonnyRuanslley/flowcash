import 'package:flowcash/themes/app_theme.dart';
import 'package:flowcash/widgets/custom/empty_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/confirmation_alert_dialog.dart';
import '../utils/open_form.dart';
import '../utils/screen_size.dart';
import '../controllers/categoryController/category_controller.dart';
import '../views/category_form.dart';

class CategoriesList extends GetView<CategoryController> {
  final bool? isEdit;
  final bool? isDelete;
  const CategoriesList({
    Key? key,
    this.isEdit = false,
    this.isDelete = false,
  }) : super(key: key);

  // @override
  // initState() {
  //   super.initState();
  //   refresh();
  // }

  // refresh() {
  //   setState(() {
  //     CategoryController.getCategories();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = ScreenSizes.getScreenHeightSize(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: AppTheme.primaryColor,
      title: Text(
        "Selecione a categoria",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppTheme.secondyColor,
        ),
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          height: sizeScreen * 0.6,
          width: double.infinity,
          child: controller.categories.isEmpty
              ? EmptyList(
                  imageSize: sizeScreen * 0.2,
                  fontSize: sizeScreen * 0.04,
                  color: AppTheme.backgroundColor,
                )
              : SingleChildScrollView(
                  child: Column(
                    children: controller.categories.map<Widget>(
                      (category) {
                        return TextButton(
                          onPressed: () {
                            if (isEdit!)
                            // openForm(CategoryForm(category: category));
                            if (isDelete!)
                              confirmationAlertDialog(
                                context: context,
                                msgTitle: "Deseja realmente excluir?",
                                completeMsg:
                                    "A categoria será excluida permanentemente!",
                                function: () {
                                  // controller.deleteCategory(
                                  //   categoryId: category['id'],
                                  // );
                                },
                              );
                          },
                          child: Text(
                            category.name ?? "",
                            style: TextStyle(
                              color: AppTheme.secondyColor,
                              fontSize: sizeScreen * 0.03,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
        ),
      ),
    );
  }
}
