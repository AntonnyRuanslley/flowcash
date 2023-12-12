import 'package:flowcash/themes/app_theme.dart';
import 'package:flowcash/utils/screen_size.dart';
import 'package:flutter/material.dart';

enum Type { recipe, expense }

class SelectTransactionType extends StatefulWidget {
  final Function onSubmit;
  final int? type;

  SelectTransactionType({
    Key? key,
    required this.onSubmit,
    this.type,
  }) : super(key: key);

  @override
  State<SelectTransactionType> createState() => _SelectTransactionTypeState();
}

class _SelectTransactionTypeState extends State<SelectTransactionType> {
  Type choice = Type.recipe;
  int inputType = 1;

  @override
  void initState() {
    super.initState();
    if (widget.type != null) {
      choice = widget.type == 1 ? Type.recipe : Type.expense;
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = ScreenSizes.getScreenWidthSize(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tipo",
          style: TextStyle(
            color: AppTheme.secondyColor,
            fontSize: sizeScreen * 0.05,
          ),
        ),
        Flexible(
          child: ListTile(
            title: Text(
              'Receita',
              style: TextStyle(
                color: AppTheme.secondyColor,
                fontSize: sizeScreen * 0.045,
              ),
            ),
            leading: Radio<Type>(
              activeColor: AppTheme.secondyColor,
              value: Type.recipe,
              groupValue: choice,
              onChanged: (Type? value) {
                setState(() {
                  choice = value!;
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
                color: AppTheme.secondyColor,
                fontSize: sizeScreen * 0.045,
              ),
            ),
            leading: Radio<Type>(
              activeColor: Colors.white,
              value: Type.expense,
              groupValue: choice,
              onChanged: (Type? value) {
                setState(() {
                  choice = value!;
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
