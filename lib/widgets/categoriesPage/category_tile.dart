import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';

import '../../utils/open_form.dart';
import '../../utils/alert/alert_dialog.dart';
import '../../themes/app_theme.dart';
import '../../models/category.dart';
import '../../controllers/categoryController/category_controller.dart';
import '../../views/category_form.dart';

class CategoryTile extends GetView<CategoryController> {
  final Category category;

  const CategoryTile({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 5,
      ),
      child: Card(
        color: Colors.white,
        elevation: 8,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 15,
          ),
          child: Row(
            children: [
              Expanded(
                child: AutoSizeText(
                  category.name ?? "",
                  style: AppTheme.subtitle1(context),
                  maxLines: 1,
                  minFontSize: 10,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              InkWell(
                onTap: () => openForm(CategoryForm(category: category)),
                child: Icon(
                  Icons.edit,
                  color: AppTheme.primaryColor,
                ),
              ),
              SizedBox(width: 15),
              InkWell(
                onTap: () {
                  alertDialog(
                    title: "Deseja realmente excluir?",
                    subtitle: "A categoria será excluida permanentemente!",
                    function: () =>
                        controller.deleteCategory(categoryId: category.id),
                  );
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
