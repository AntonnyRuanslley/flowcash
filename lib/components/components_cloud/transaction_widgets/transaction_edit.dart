import 'dart:convert';

import 'package:cas/components/components_cloud/category_widgets/categorys_file.dart';
import 'package:cas/components/components_cloud/type_file.dart';

import 'package:cas/data/urls.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionEdit extends StatefulWidget {
  final transaction;
  final category;
  final Function onRefresh;

  TransactionEdit(this.transaction, this.category, this.onRefresh);
  @override
  State<TransactionEdit> createState() => _TransactionEditState();
}

class _TransactionEditState extends State<TransactionEdit> {
  final message = SnackBar(
    content: Text(
      "Transação editada com sucesso",
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.blueAccent,
  );

  TextEditingController? _inputDescription = TextEditingController();
  TextEditingController? _inputValeu = TextEditingController();
  int? _inputCategory;
  int? _inputType;
  DateTime _selectDate = DateTime.now();

  void initState() {
    _inputDescription!.text = widget.transaction['description'];
    _inputCategory = widget.transaction['category_id'];
    _inputValeu!.text =
        NumberFormat('#.00').format(widget.transaction['value']!);
    _inputType = widget.transaction['type'];
    _selectDate = DateTime.parse(widget.transaction['date']);
  }

  Future<void> putTransaction() async {
    var description = _inputDescription!.text;
    var category = _inputCategory!;
    var value = double.tryParse(_inputValeu!.text) ?? 0.0;
    var type = _inputType ?? 1;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse(urls['user_logged']!);
    var answer = await http.get(url, headers: {
      "Authorization": "Bearer ${sharedPreferences.getString('token')}",
    });
    if (answer.statusCode == 200) {
      String user_id = jsonDecode(answer.body)['id'].toString();
      url = Uri.parse("${urls['transactions']!}/${widget.transaction['id']}");
      answer = await http.put(
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
      if (answer.statusCode == 200) {
        widget.onRefresh();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(message);
      } else {
        return;
      }
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size.width;

    _decoration() {
      return InputDecoration(
        hintStyle: TextStyle(
          fontSize: sizeScreen * 0.05,
          color: Colors.white54,
        ),
        counterStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
        contentPadding: EdgeInsets.only(
            left: sizeScreen * 0.05,
            top: sizeScreen * 0.041,
            bottom: sizeScreen * 0.041,
            right: sizeScreen * 0.05),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(sizeScreen * 0.04),
          borderSide: BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(sizeScreen * 0.04),
          borderSide: BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          "Edição de transação",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        content: SizedBox(
          height: sizeScreen * 1.2,
          child: Padding(
            padding: EdgeInsets.all(sizeScreen * 0.01),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextField(
                  maxLines: 1,
                  maxLength: 25,
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                  decoration: _decoration(),
                  controller: _inputDescription,
                ),
                CategorysFile(_addCategory, true, widget.category!),
                Row(
                  children: [
                    Text(
                      "  R\$  ",
                      style: TextStyle(
                          color: Colors.white, fontSize: sizeScreen * 0.06),
                    ),
                    Flexible(
                      child: TextField(
                        style: TextStyle(
                            fontSize: sizeScreen * 0.05,
                            color: Theme.of(context).colorScheme.secondary),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: _decoration(),
                        maxLines: 1,
                        controller: _inputValeu,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: sizeScreen * 0.28,
                  child: TypeFile(_addType, false, widget.transaction['type']!),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.date_range_outlined,
                        color: Theme.of(context).colorScheme.secondary,
                        size: sizeScreen * 0.082,
                      ),
                      onPressed: _showDatePicker,
                    ),
                    Container(
                      width: sizeScreen * 0.45,
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
                  width: sizeScreen * 1,
                  padding: EdgeInsets.all(sizeScreen * 0.005),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          child: Text(
                            'Cancelar',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: sizeScreen * 0.047,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      SizedBox(width: sizeScreen * 0.03),
                      TextButton(
                        child: Text(
                          'Salvar',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: sizeScreen * 0.047,
                              fontWeight: FontWeight.bold),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                        ),
                        onPressed: () => putTransaction(),
                      ),
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

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.parse(widget.transaction['date']!),
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
}
