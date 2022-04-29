import '../data/dummy_category.dart';

import 'package:cas/components/categorys_file.dart';

import '../components/category_form.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Type { recipe, expense }

class TransactionForm extends StatefulWidget {
  final Function(String, String, double, int, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  var categorys = DUMMY_CATEGORY.map((category) => category.name).toList();
  Type? _choice = Type.recipe;

  final _inputDescription = TextEditingController();
  var _inputCategory = DUMMY_CATEGORY[1].name;
  final _inputValeu = TextEditingController();
  int _inputType = 1;
  DateTime _selectDate = DateTime.now();

  _openCategoryFormModal(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return CategoryForm();
        });
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _selectDate,
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
      locale: const Locale('pt', 'BR'),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectDate = pickedDate;
      });
    });
  }

  _submitForm() {
    final description = _inputDescription.text;
    final category = _inputCategory;
    final value = double.tryParse(_inputValeu.text) ?? 0.0;
    if (description.isEmpty || category.isEmpty || value <= 0) {
      return;
    }
    widget.onSubmit(description, category, value, _inputType, _selectDate);
  }

  @override
  Widget build(BuildContext context) {
    final sizeSreen = MediaQuery.of(context).size.width;

    _decoration(String label) {
      return InputDecoration(
        hintText: label,
        hintStyle: TextStyle(
          fontSize: sizeSreen * 0.05,
          color: Colors.white54,
        ),
        contentPadding: EdgeInsets.only(
            left: sizeSreen * 0.05,
            top: sizeSreen * 0.041,
            bottom: sizeSreen * 0.041,
            right: sizeSreen * 0.05),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(sizeSreen * 0.04),
          borderSide: BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(sizeSreen * 0.04),
          borderSide: BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: SizedBox(
        height: sizeSreen * 1,
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextField(
                maxLines: 1,
                cursorColor: Theme.of(context).colorScheme.secondary,
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
                decoration: _decoration("Descrição"),
                controller: _inputDescription,
                onSubmitted: (_) => _submitForm(),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.add_circle_outline_outlined,
                      color: Theme.of(context).colorScheme.secondary,
                      size: sizeSreen * 0.075,
                    ),
                    onPressed: () => _openCategoryFormModal(context),
                  ),
                  Flexible(
                      child: DropdownButton<String>(
                    value: _inputCategory,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValeu) {
                      setState(() {
                        _inputCategory = newValeu!;
                      });
                    },
                    items:
                        categorys.map<DropdownMenuItem<String>>((String valeu) {
                      return DropdownMenuItem<String>(
                        value: _inputCategory,
                        child: Text(_inputCategory),
                      );
                    }).toList(),
                  )

                      /*TextField(
                      style: TextStyle(
                          fontSize: sizeSreen * 0.05,
                          color: Theme.of(context).colorScheme.secondary),
                      maxLines: 1,
                      decoration: _decoration("Categoria"),
                      controller: 
                  CategorysFile(), 
                      onSubmitted: (_) => _submitForm(),
                    ),*/
                      ),
                ],
              ),
              Row(
                children: [
                  Text(
                    " R\$ ",
                    style: TextStyle(
                        color: Colors.white, fontSize: sizeSreen * 0.06),
                  ),
                  Flexible(
                    child: TextField(
                      style: TextStyle(
                          fontSize: sizeSreen * 0.05,
                          color: Theme.of(context).colorScheme.secondary),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      maxLines: 1,
                      decoration: _decoration("0,00"),
                      controller: _inputValeu,
                      onSubmitted: (_) => _submitForm(),
                    ),
                  )
                ],
              ),
              Container(
                height: sizeSreen * 0.28,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tipo",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: sizeSreen * 0.05),
                    ),
                    Flexible(
                      child: ListTile(
                        title: Text(
                          'Receita',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: sizeSreen * 0.045),
                        ),
                        leading: Radio<Type>(
                          activeColor: Colors.white,
                          value: Type.recipe,
                          groupValue: _choice,
                          onChanged: (Type? value) {
                            setState(() {
                              _choice = value;
                              _inputType = 2;
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
                              fontSize: sizeSreen * 0.045),
                        ),
                        leading: Radio<Type>(
                          activeColor: Colors.white,
                          value: Type.expense,
                          groupValue: _choice,
                          onChanged: (Type? value) {
                            setState(() {
                              _choice = value;
                              _inputType = 1;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.date_range_outlined,
                      color: Theme.of(context).colorScheme.secondary,
                      size: sizeSreen * 0.082,
                    ),
                    onPressed: _showDatePicker,
                  ),
                  Container(
                    width: sizeSreen * 0.45,
                    child: Text(
                      'Data selecionada: ${DateFormat('dd/MM/y', "pt_BR").format(_selectDate)}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
