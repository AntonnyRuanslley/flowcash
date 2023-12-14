import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/screen_size.dart';
import '../themes/app_theme.dart';
import '../models/category.dart';
import '../controllers/categoryController/category_controller.dart';

class CategoryForm extends StatefulWidget {
  final Category? category;
  const CategoryForm({
    Key? key,
    this.category,
  }) : super(key: key);

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final inputName = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      inputName.text = widget.category!.name ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = ScreenSizes.getScreenWidthSize(context);

    onSubmit() {
      if (widget.category == null) {
        CategoryController().createCategory(
          categoryName: inputName.text.trim(),
        );
      } else {
        CategoryController().updateCategory(
          categoryId: widget.category!.id,
          categoryName: inputName.text.trim(),
        );
      }
    }

    return AlertDialog(
      title: Text(
        widget.category == null ? "Nova categoria" : "Edição de categoria",
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: inputName,
              onSubmitted: (_) => onSubmit(),
              decoration: InputDecoration(
                labelText: 'Nome',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: AppTheme.primaryColor,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: AppTheme.primaryColor,
                    width: 1.5,
                  ),
                ),
              ),
              cursorColor: AppTheme.primaryColor,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text(
                      'Cancelar',
                      style: TextStyle(
                        fontSize: sizeScreen * 0.047,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    onPressed: () => Get.back(),
                  ),
                  SizedBox(width: sizeScreen * 0.02),
                  TextButton(
                    child: Text(
                      widget.category == null ? 'Adicionar' : 'Salvar',
                      style: TextStyle(
                        fontSize: sizeScreen * 0.047,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.secondyColor,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                    ),
                    onPressed: () => onSubmit(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
