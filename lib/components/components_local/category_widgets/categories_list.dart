import 'package:cas/components/components_local/category_widgets/category_edit.dart';
import 'package:cas/data/categories.dart';
import 'package:cas/utils/screen_size.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CategoriesList extends StatefulWidget {
  final int who;

  CategoriesList(this.who);

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  final _categoriesBox = Hive.box('categories');

  void _getCategories() {
    final data = _categoriesBox.keys.map((key) {
      final value = _categoriesBox.get(key);
      return {
        "id": key,
        "name": value["name"],
      };
    }).toList();

    setState(() {
      categories = data.reversed.toList();
    });
  }

  Future<void> _deleteCategory(id) async {
    await _categoriesBox.delete(id);
    _refresh();
    Navigator.of(context).pop();
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
              : Column(
                  children: categories.map<Widget>(
                    (category) {
                      return TextButton(
                        onPressed: () {
                          widget.who == 0
                              ? _openForm(context, category)
                              : _openAlert(context, category['id']);
                        },
                        child: Text(
                          category['name'],
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: sizeScreen * 0.03),
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ).toList(),
                ),
        ),
      ),
    );
  }

  @override
  initState() {
    _refresh();
    super.initState();
  }

  _refresh() {
    _getCategories();
  }

  _openForm(context, category) {
    showDialog(
        context: context,
        builder: (context) {
          return CategoryEdit(category, _refresh);
        });
  }

  _openAlert(context, id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deseja realmente excluir?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const [
                Text('A categoria será excluida permanentemente!'),
              ],
            ),
          ),
          actions: [
            TextButton(
                child: const Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            TextButton(
              child: const Text('Excluir'),
              onPressed: () {
                _deleteCategory(id);
              },
            ),
          ],
        );
      },
    );
  }
}
