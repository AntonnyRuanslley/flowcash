import 'package:flutter/material.dart';

import '../utils/confirmation_alert_dialog.dart';
import '../utils/open_form.dart';
import '../utils/screen_size.dart';
import '../data/categories.dart';
import '../controllers/categoryController/category_controller.dart';
import '../views/category_form.dart';

class CategoriesList extends StatefulWidget {
  final bool? isEdit;
  final bool? isDelete;
  const CategoriesList({
    Key? key,
    this.isEdit = false,
    this.isDelete = false,
  }) : super(key: key);

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  initState() {
    super.initState();
    refresh();
  }

  refresh() {
    setState(() {
      CategoryController.getCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = ScreenSizes.getScreenHeightSize(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Text(
        "Selecione a categoria",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          height: sizeScreen * 0.6,
          child: categories.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: sizeScreen * 0.01),
                      child: Container(
                        height: sizeScreen * 0.23,
                        child: const Image(
                          image: AssetImage(
                            'assets/images/vazio.png',
                          ),
                          color: Colors.white,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Sem categorias!',
                        style: TextStyle(
                          fontSize: sizeScreen * 0.045,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                )
              : SingleChildScrollView(
                  child: Column(
                    children: categories.map<Widget>(
                      (category) {
                        return TextButton(
                          onPressed: () {
                            if (widget.isEdit!)
                              openForm(
                                CategoryForm(
                                  category: category,
                                ),
                              );
                            if (widget.isDelete!)
                              confirmationAlertDialog(
                                context: context,
                                msgTitle: "Deseja realmente excluir?",
                                completeMsg:
                                    "A categoria será excluida permanentemente!",
                                function: () {
                                  CategoryController.deleteCategory(
                                    context: context,
                                    categoryId: category['id'],
                                    onRefresh: refresh,
                                  );
                                },
                              );
                          },
                          child: Text(
                            category['name'],
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
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
