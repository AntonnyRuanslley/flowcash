import '../data/dummy_category.dart';
import '../models/category.dart';

import 'package:flutter/material.dart';

import 'dart:math';

class CategoryForm extends StatefulWidget {
  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size.width;

    _addCategory(String name) {
      if (name.isEmpty) {
        return;
      }
      final newCategory = Category(
        id: 'C' + Random().nextInt(100).toString(),
        name: name,
      );
      setState(() {
        DUMMY_CATEGORY.add(newCategory);
      });
      Navigator.of(context).pop();
    }

    return AlertDialog(
      title: Text("Nova categoria"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              onSubmitted: (_) => _addCategory(_nameController.text),
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
                      _addCategory(_nameController.text);
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
