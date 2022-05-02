import 'package:cas/models/category.dart';

import '../data/dummy_category.dart';

import 'package:flutter/material.dart';

class CategorysFile extends StatefulWidget {
  final Function(String) onSubmit;
  final bool isEdit;
  final String category;

  CategorysFile(this.onSubmit, this.isEdit, this.category);

  @override
  State<CategorysFile> createState() => _CategorysFileState();
}

class _CategorysFileState extends State<CategorysFile> {
  String? _category;
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
          widget.isEdit ? "Categoria" : widget.category,
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
        items: DUMMY_CATEGORY
            .map<DropdownMenuItem<String>>((Category categorySelected) {
          return DropdownMenuItem<String>(
            value: categorySelected.name,
            child: Text(categorySelected.name),
          );
        }).toList(),
        onChanged: (String? newCategory) {
          setState(() {
            _category = newCategory!;
          });
          widget.onSubmit(_category!);
        },
      ),
    );
  }
}
