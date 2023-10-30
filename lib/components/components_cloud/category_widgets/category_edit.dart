import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../data/urls.dart';

class CategoryEdit extends StatefulWidget {
  final category;
  final Function onRefresh;

  CategoryEdit(this.category, this.onRefresh);

  @override
  State<CategoryEdit> createState() => _CategoryEditState();
}

class _CategoryEditState extends State<CategoryEdit> {
  TextEditingController? _inputName = TextEditingController();

  @override
  void initState() {
    super.initState();
    _inputName!.text = widget.category['name'];
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size.width;

    Future<void> _putCategory() async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var url =
          Uri.parse("${urls['categories']!}/${widget.category['id']}/update");
      var answer = await http.post(
        url,
        body: {
          "name": _inputName!.text,
        },
        headers: {
          "Authorization": "Bearer ${sharedPreferences.getString('token')}",
        },
      );
      if (answer.statusCode == 200) {
        widget.onRefresh();
        Navigator.of(context).pop();
      } else {
        return;
      }
    }

    return AlertDialog(
      title: const Text("Edição de categoria"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _inputName!,
              onSubmitted: (_) => _putCategory(),
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
                      _putCategory();
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
