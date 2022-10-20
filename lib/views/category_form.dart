import 'package:cas/controllers/categoryController/category_controller.dart';
import 'package:cas/utils/screen_size.dart';
import 'package:flutter/material.dart';

class CategoryForm extends StatefulWidget {
  final Map<String, dynamic>? category;
  final Function()? onRefresh;
  const CategoryForm({
    Key? key,
    this.category,
    this.onRefresh,
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
      inputName.text = widget.category!['name'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = ScreenSizes.getScreenWidthSize(context);

    onSubmit() {
      if (widget.category == null) {
        CategoryController.createCategory(
          context: context,
          categoryName: inputName.text.trim(),
        );
      } else {
        CategoryController.updateCategory(
          context: context,
          categoryName: inputName.text.trim(),
          categoryId: widget.category!['id'],
          onRefresh: widget.onRefresh!,
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
              ),
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
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(width: sizeScreen * 0.02),
                  TextButton(
                    child: Text(
                      widget.category == null ? 'Adicionar' : 'Salvar',
                      style: TextStyle(
                        fontSize: sizeScreen * 0.047,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
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
