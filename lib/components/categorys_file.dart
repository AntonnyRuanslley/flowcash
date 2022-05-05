import 'dart:convert';

import 'package:cas/data/urls.dart';
//import 'package:cas/models/category.dart';

//import '../data/dummy_category.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CategorysFile extends StatefulWidget {
  final Function(int) onSubmit;
  //final bool isEdit;
  final int? category;

  CategorysFile(this.onSubmit, /*this.isEdit, */ [this.category]);

  @override
  State<CategorysFile> createState() => _CategorysFileState();
}

class _CategorysFileState extends State<CategorysFile> {
  int? _category;
  List _categories = [];

  Future<void> getCategories() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse(urls['categories']!);
    var answer = await http.get(
      url,
      headers: {
        "Authorization": "Bearer ${sharedPreferences.getString('token')}",
      },
    );
    if (answer.statusCode == 200) {
      setState(() {
        _categories = jsonDecode(answer.body)['data'];
      });
    }
  }

  @override
  void initState() {
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: sizeScreen * 0.04),
      decoration: BoxDecoration(
        border: Border.all(
            width: 2, color: Theme.of(context).colorScheme.secondary),
        borderRadius: BorderRadius.circular(sizeScreen * 0.04),
      ),
      child: DropdownButton(
        hint: Text(
          /*widget.isEdit ? */ "Categoria", //: "${widget.category!}" MEXER
          style: TextStyle(
            fontSize: sizeScreen * 0.05,
            color: Colors.white54,
          ),
        ),
        dropdownColor: Theme.of(context).colorScheme.primary,
        icon: Icon(Icons.keyboard_arrow_down_rounded,
            color: Theme.of(context).colorScheme.secondary),
        style: TextStyle(
            fontSize: sizeScreen * 0.05,
            color: Theme.of(context).colorScheme.secondary),
        underline: Container(height: 0),
        borderRadius: BorderRadius.circular(sizeScreen * 0.04),
        isExpanded: true,
        value: _category,
        items: _categories.map((categorySelected) {
          return DropdownMenuItem(
            value: int.parse(categorySelected['id'].toString()),
            child: Text(categorySelected['name']),
          );
        }).toList(),
        onChanged: (int? newCategory) {
          setState(() { 
            _category = newCategory!;
          });
          widget.onSubmit(_category!);
        },
      ),
    );
  }
}
