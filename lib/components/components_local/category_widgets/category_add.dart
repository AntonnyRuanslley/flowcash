import 'package:hive/hive.dart';

import 'package:flutter/material.dart';

class CategoryForm extends StatefulWidget {
  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _inputName = TextEditingController();
  final _categoriesBox = Hive.box('categories');

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size.width;

    Future<void> _postCategory() async {
      if (_inputName.text.isEmpty) {
        return;
      }
      var newCategory = ({
        "name": _inputName.text,
      });
      await _categoriesBox.add(newCategory);
      Navigator.of(context).pop();
    }

    return AlertDialog(
      title: Text("Nova categoria"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _inputName,
              onSubmitted: (_) => _postCategory(),
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
                    child: Text('Cancelar',
                        style: TextStyle(
                          fontSize: sizeScreen * 0.047,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(width: sizeScreen * 0.02),
                  TextButton(
                    child: Text('Adicionar',
                        style: TextStyle(
                          fontSize: sizeScreen * 0.047,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        )),
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () {
                      _postCategory();
                    },
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
