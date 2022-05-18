import 'package:flutter/material.dart';

enum Type { recipe, expense }

class TypeFile extends StatefulWidget {
  final Function onSubmit;
  bool isAdd;
  int? type;

  TypeFile(
    this.onSubmit,
    this.isAdd, [
    this.type,
  ]);

  @override
  State<TypeFile> createState() => _TypeFileState();
}

class _TypeFileState extends State<TypeFile> {
  Type? _choice;
  int? inputType = 1;

  @override
  void initState() {
    _choice = widget.isAdd
        ? Type.recipe
        : widget.type == 1
            ? Type.recipe
            : Type.expense;
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size.width - MediaQuery.of(context).padding.top;

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
                  inputType = 1;
                });
                widget.onSubmit(inputType);
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
                  inputType = 2;
                });
                widget.onSubmit(inputType);
              },
            ),
          ),
        ),
      ],
    );
  }
}
