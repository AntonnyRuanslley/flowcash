import 'package:flutter/material.dart';

class CategoryForm extends StatefulWidget {
  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return AlertDialog(
      title: Text("Nova categoria"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _categoryController,
              onSubmitted: (_) => {}, //_submitForm(),
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
                          fontSize: width * 0.047,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(width: width * 0.02),
                  TextButton(
                    child: Text('Adicionar',
                        style: TextStyle(
                          fontSize: width * 0.047,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        )),
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
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
