import 'dart:convert';

import 'package:cas/components/components_cloud/category_widgets/category_edit.dart';
import 'package:cas/data/urls.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CategoriesList extends StatefulWidget {
  final int who;

  CategoriesList(this.who);

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  List _categories = [];
  Future<String>? getCategories;

  Future<String> _getCategories() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse(urls['categories']!);
    var answer = await http.get(
      url,
      headers: {
        "Authorization": "Bearer ${sharedPreferences.getString('token')}",
      },
    );
    if (answer.statusCode == 200) {
      print(answer.statusCode);
      setState(() {
        _categories = jsonDecode(answer.body)['data'];
      });
      return "Sucesso";
    } else {
      return "Erro";
    }
  }

  Future<void> _deleteCategory(id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse("${urls['categories']!}/${id}");
    var answer = await http.delete(
      url,
      headers: {
        "Authorization": "Bearer ${sharedPreferences.getString('token')}",
      },
    );
    if (answer.statusCode == 204) {
      Navigator.of(context).pop();
      _refresh();
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size.height;

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
          child: FutureBuilder<String>(
            future: getCategories,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.secondary),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Erro: ${snapshot.error}'),
                  ),
                );
              }
              return _categories.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: sizeScreen * 0.01),
                          child: Container(
                            height: sizeScreen * 0.25,
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
                  : ListView.builder(
                      itemCount: _categories.length,
                      itemBuilder: (ctx, i) {
                        return TextButton(
                          onPressed: () {
                            widget.who == 0
                                ? _openForm(context, _categories[i])
                                : _openAlert(context, _categories[i]['id']);
                          },
                          child: Text(
                            _categories[i]['name'],
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: sizeScreen * 0.03),
                          ),
                        );
                      },
                    );
            },
          ),
        ),
      ),
    );
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

  _openForm(context, category) {
    showDialog(
        context: context,
        builder: (context) {
          return CategoryEdit(category, _refresh);
        });
  }

  @override
  initState() {
    _refresh();
    super.initState();
  }

  _refresh() {
    getCategories = _getCategories();
  }
}
