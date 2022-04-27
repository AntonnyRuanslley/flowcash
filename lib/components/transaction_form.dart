import 'package:cas/components/category_form.dart';

import '../data/dummy_transaction.dart';

import '../models/transaction.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'dart:math';

class TransanctionForm extends StatefulWidget {
  @override
  State<TransanctionForm> createState() => _TransanctionFormState();
}

enum Type { expense, recipe }

class _TransanctionFormState extends State<TransanctionForm> {
  final _titleController = TextEditingController();
  final _valeuController = TextEditingController();
  DateTime _selectDate = DateTime.now();

  Type? _character = Type.expense;

  _addTrasanction(String category, String description, DateTime date,
      int status, double value, int type) {
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

  /* _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valeuController.text) ?? 0.0;
    if (title.isEmpty || value <= 0 || _selectDate == null) {
      return;
    }
    _addTrasanction(title, value, _selectDate);
  }*/

  _removeTransaction(String id) {
    setState(() {
      DUMMY_TRANSACTION.removeWhere((tr) => tr.id == id);
    });
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
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

  _openCategoryFormModal(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return CategoryForm();
        });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

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
        child: Container(
          height: width * 1,
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
                  decoration: InputDecoration(
                    hintText: "Descrição",
                    hintStyle: TextStyle(
                      fontSize: width * 0.05,
                      color: Colors.white54,
                    ),
                    contentPadding: EdgeInsets.only(
                        left: width * 0.05,
                        top: width * 0.041,
                        bottom: width * 0.041,
                        right: width * 0.05),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.04),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.04),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                  ),
                  //controller: _titleController,
                  //onSubmitted: (_) => _submitForm(),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.add_circle_outline_outlined,
                        color: Theme.of(context).colorScheme.secondary,
                        size: width * 0.075,
                      ),
                      onPressed: () => _openCategoryFormModal(context),
                    ),
                    Flexible(
                      child: TextField(
                        style: TextStyle(
                            fontSize: width * 0.05,
                            color: Theme.of(context).colorScheme.secondary),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: "Categoria",
                          hintStyle: TextStyle(color: Colors.white54),
                          contentPadding: EdgeInsets.only(
                              left: width * 0.04,
                              top: width * 0.041,
                              bottom: width * 0.041,
                              right: width * 0.04),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.04),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.04),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                        ),
                        //controller: _controllerValor,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      " R\$ ",
                      style: TextStyle(
                          color: Colors.white, fontSize: width * 0.06),
                    ),
                    Flexible(
                      child: TextField(
                        style: TextStyle(
                            fontSize: width * 0.05,
                            color: Theme.of(context).colorScheme.secondary),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: "0,00",
                          hintStyle: TextStyle(color: Colors.white54),
                          contentPadding: EdgeInsets.only(
                              left: width * 0.04,
                              top: width * 0.041,
                              bottom: width * 0.041,
                              right: width * 0.04),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.04),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.04),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                        ),
                        //controller: _controllerValor,
                      ),
                    )
                  ],
                ),
                Container(
                  height: width * 0.28,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tipo",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: width * 0.05),
                      ),
                      Flexible(
                        child: ListTile(
                          title: Text(
                            'Despesa',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: width * 0.045),
                          ),
                          leading: Radio<Type>(
                            activeColor: Colors.white,
                            value: Type.expense,
                            groupValue: _character,
                            onChanged: (Type? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        child: ListTile(
                          title: Text(
                            'Receita',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: width * 0.045),
                          ),
                          leading: Radio<Type>(
                            activeColor: Colors.white,
                            value: Type.recipe,
                            groupValue: _character,
                            onChanged: (Type? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                      )
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
                        size: width * 0.082,
                      ),
                      onPressed: _showDatePicker,
                    ),
                    Container(
                      width: width * 0.45,
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
            width: width * 1,
            padding: const EdgeInsets.all(3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    child: Text(
                      'Cancelar',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: width * 0.047,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                SizedBox(width: width * 0.03),
                TextButton(
                    child: Text(
                      'Adicionar',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: width * 0.047,
                          fontWeight: FontWeight.bold),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
