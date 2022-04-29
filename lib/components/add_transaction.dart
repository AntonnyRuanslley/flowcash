import 'package:cas/components/categorys_file.dart';

import '../components/category_form.dart';
import '../components/transaction_form.dart';

import '../data/dummy_transaction.dart';

import '../models/transaction.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'dart:math';

class AddTransaction extends StatefulWidget {
  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  Type? _choice = Type.recipe;

  final _inputDescription = TextEditingController();
  final _inputValeu = TextEditingController();
  String? _inputCategory;
  int _inputType = 1;
  DateTime _selectDate = DateTime.now();

  _addTrasanction(String description, String category, double value, int type,
      DateTime date) {
    final newTransaction = Transaction(
      id: 'T' + Random().nextInt(1000).toString(),
      category: category,
      description: description,
      date: date,
      status: 1,
      type: type,
      value: value,
    );
    setState(() {
      DUMMY_TRANSACTION.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      DUMMY_TRANSACTION.removeWhere((tr) => tr.id == id);
    });
  }

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
    if (description.isEmpty || category == null || value <= 0) {
      return;
    }
    _addTrasanction(description, category, value, _inputType, _selectDate);
  }

  _addCategory(String category) {
    setState(() {
      _inputCategory = category;
    });
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

    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        "Nova transação",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      content: SingleChildScrollView(
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
                      child: CategorysFile(_addCategory),
                    )
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
                                _inputType = 1;
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
                                _inputType = 2;
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
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 13, right: 17, bottom: 10),
          child: Container(
            width: sizeSreen * 1,
            padding: const EdgeInsets.all(3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    child: Text(
                      'Cancelar',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: sizeSreen * 0.047,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                SizedBox(width: sizeSreen * 0.03),
                TextButton(
                    child: Text(
                      'Adicionar',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: sizeSreen * 0.047,
                          fontWeight: FontWeight.bold),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () {
                      _submitForm();
                    }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
