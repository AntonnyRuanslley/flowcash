import 'package:flutter/material.dart';

enum Type { recipe, expense }

class TypeFile extends StatefulWidget {
  int inputType;
  final bool isAdd;

  TypeFile(this.inputType, this.isAdd);

  @override
  State<TypeFile> createState() => _TypeFileState();
}

class _TypeFileState extends State<TypeFile> {
  Type? _choice = Type.recipe;

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tipo",
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: sizeScreen * 0.05),
        ),
        Flexible(
          child: ListTile(
            title: Text(
              'Receita',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: sizeScreen * 0.045),
            ),
            leading: Radio<Type>(
              activeColor: Colors.white,
              value: Type.recipe,
              groupValue: _choice,
              onChanged: (Type? value) {
                setState(() {
                  _choice = value;
                  widget.inputType = 1;
                });
              },
            ),
          ),
        ),
        Flexible(
          child: ListTile(
            title: Text(
              'Despesa',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: sizeScreen * 0.045),
            ),
            leading: Radio<Type>(
              activeColor: Colors.white,
              value: Type.expense,
              groupValue: _choice,
              onChanged: (Type? value) {
                setState(() {
                  _choice = value;
                  widget.inputType = 2;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
