import 'dart:convert';

import 'package:cas/components/categorys_file.dart';
import 'package:cas/components/type_file.dart';
import 'package:cas/data/urls.dart';

import '../components/category_form.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final Function() onSubmit;
  final bool isAdd;

  final String? id;
  final String? editDescription;
  final int? editCategory;
  final double? editValue;
  final int? editType;
  final DateTime? editDate;

  TransactionForm(this.onSubmit, this.isAdd,
      [this.id,
      this.editDescription,
      this.editCategory,
      this.editValue,
      this.editType,
      this.editDate]);
  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _inputDescription = TextEditingController();
  final _inputValeu = TextEditingController();
  int? _inputCategory;
  int? _inputType;
  DateTime _selectDate = DateTime.now();

  Future<void> postTransaction() async {
    var description = _inputDescription.text;
    var category = _inputCategory!;
    var value = double.tryParse(_inputValeu.text) ?? 0.0;
    var type = _inputType ?? 1;
    if (description.isEmpty || category == null || value <= 0) {
      return;
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse(urls['user_logged']!);
    var answer = await http.get(url, headers: {
      "Authorization": "Bearer ${sharedPreferences.getString('token')}",
    });
    if (answer.statusCode == 200) {
      String user_id = jsonDecode(answer.body)['id'].toString();
      url = Uri.parse(urls['transactions']!);
      answer = await http.post(
        url,
        body: {
          "description": description,
          "category_id": category.toString(),
          "value": value.toString(),
          "type": type.toString(),
          "status": 1.toString(),
          "date": _selectDate.toString(),
          "user_id": user_id,
        },
        headers: {
          "Authorization": "Bearer ${sharedPreferences.getString('token')}",
        },
      );
      if (answer.statusCode == 201) {
        widget.onSubmit;
        print("blz1");
        Navigator.of(context).pop();
      } else {
        return;
      }
    } else {
      print(answer.statusCode);
      return;
    }
  }

  _submitForm() {
    /*String? description;
    int? category;
    double value;
    int? type;
    if (widget.isAdd) {
      description = _inputDescription.text;
      category = _inputCategory;
      value = double.tryParse(_inputValeu.text) ?? 0.0;
      type = _inputType ?? 1;
      if (description.isEmpty || category == null || value <= 0) {
        return;
      }
      widget.onSubmit(description, category, value, type, _selectDate);
    } else {
      description = _inputDescription.text.isEmpty
          ? widget.editDescription
          : _inputDescription.text;
      category = _inputCategory ?? widget.editCategory;
      value = _inputValeu.text.isEmpty
          ? widget.editValue as double
          : double.tryParse(_inputValeu.text) ?? 0.0;
      type = _inputType ?? widget.editType;
      widget.onSubmit(
          widget.id, description, category, value, type, _selectDate);
    }*/
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: widget.isAdd ? _selectDate : widget.editDate!,
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

  _addCategory(int category) {
    setState(() {
      _inputCategory = category;
    });
  }

  _addType(int type) {
    setState(() {
      _inputType = type;
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
        widget.isAdd ? "Nova transação" : "Edição de transação",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          height: sizeSreen * 1.2,
          child: Padding(
            padding: EdgeInsets.all(sizeSreen * 0.01),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextField(
                  maxLines: 1,
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                  decoration: widget.isAdd
                      ? _decoration("Descrição")
                      : _decoration(widget.editDescription!),
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
                      /*: CategorysFile(
                              _addCategory, widget.isAdd, widget.editCategory!),*/
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "  R\$  ",
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
                        decoration: _decoration(widget.isAdd
                            ? "0,00"
                            : NumberFormat('#.00', 'pt-BR')
                                .format(widget.editValue!)),
                        controller: _inputValeu,
                        onSubmitted: (_) => _submitForm(),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: sizeSreen * 0.28,
                  child: widget.isAdd
                      ? TypeFile(_addType, widget.isAdd)
                      : TypeFile(_addType, widget.isAdd, widget.editType!),
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
                Container(
                  width: sizeSreen * 1,
                  padding: EdgeInsets.all(sizeSreen * 0.005),
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
                            widget.isAdd ? 'Adicionar' : 'Salvar',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: sizeSreen * 0.047,
                                fontWeight: FontWeight.bold),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                          ),
                          onPressed: () {
                            postTransaction();
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
