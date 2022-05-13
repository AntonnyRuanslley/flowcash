import 'package:cas/data/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryAdd extends StatefulWidget {
  @override
  State<CategoryAdd> createState() => _CategoryAddState();
}

class _CategoryAddState extends State<CategoryAdd> {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size.width;

    Future<void> _postCategory(String name) async {
      if (name.isEmpty) {
        return;
      }
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var url = Uri.parse(urls['categories']!);
      var answer = await http.post(
        url,
        body: {
          "name": name,
        },
        headers: {
          "Authorization": "Bearer ${sharedPreferences.getString('token')}",
        },
      );
      if (answer.statusCode == 201) {
        Navigator.of(context).pop();
      } else {
        return;
      }
    }

    return AlertDialog(
      title: const Text("Nova categoria"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              onSubmitted: (_) => _postCategory(_nameController.text),
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
                      _postCategory(_nameController.text);
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
