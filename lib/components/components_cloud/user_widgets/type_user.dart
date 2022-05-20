import 'package:flutter/material.dart';

enum Type { normal, admin }

class TypeUser extends StatefulWidget {
  final Function onSubmit;
  bool isAdd;
  int? type;

  TypeUser(this.onSubmit, this.isAdd, [this.type]);

  @override
  State<TypeUser> createState() => _TypeUUserState();
}

class _TypeUUserState extends State<TypeUser> {
  Type _choice = Type.normal;
  int? inputType = 0;

  @override
  void initState() {
    _choice = widget.isAdd
        ? Type.normal
        : widget.type == 1
            ? Type.normal
            : Type.admin;
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tipo de usuário",
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: sizeScreen * 0.05),
        ),
        Flexible(
          child: ListTile(
            title: Text(
              'Normal',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: sizeScreen * 0.045),
            ),
            leading: Radio<Type>(
              activeColor: Colors.white,
              value: Type.normal,
              groupValue: _choice,
              onChanged: (Type? value) {
                setState(() {
                  _choice = value!;
                  inputType = 0;
                });
                widget.onSubmit(inputType);
              },
            ),
          ),
        ),
        Flexible(
          child: ListTile(
            title: Text(
              'Admin',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: sizeScreen * 0.045),
            ),
            leading: Radio<Type>(
              activeColor: Colors.white,
              value: Type.admin,
              groupValue: _choice,
              onChanged: (Type? value) {
                setState(() {
                  _choice = value!;
                  inputType = 1;
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
