import 'package:cas/models/category.dart';

import '../components/information_transaction.dart';

//import '../models/transaction.dart';

import 'package:cas/data/urls.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class TransactionsFile extends StatefulWidget {
  final transaction;
  final Function onRemove;

  TransactionsFile(this.transaction, this.onRemove);

  @override
  State<TransactionsFile> createState() => _TransactionsFileState();
}

class _TransactionsFileState extends State<TransactionsFile> {
  List categories = [];

  Future<void> getCategory() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse(urls['categories']!);
    var answer = await http.get(
      url,
      headers: {
        "Authorization": "Bearer ${sharedPreferences.getString('token')}",
      },
    );
    if (answer.statusCode == 200) {
      setState(() {
        categories = jsonDecode(answer.body)['data'];
      });
    } else {
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    getCategory();
  }

  bool? _banlacePos(type) {
    if (type == 1) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size.height;

    _searchCategory(id) {
      for (var category in categories) {
        if (id == category['id']) {
          return category['name'];
        }
      }
    }

    _passMainRemove(String id) {
      widget.onRemove(id);
    }

    _openInformation(category) {
      setState(() {
        showDialog(
            context: context,
            builder: (context) {
              return InformationTransaction(
                  widget.transaction, category, _passMainRemove);
            });
      });
    }

    return TextButton(
      onPressed: () => _openInformation(
          _searchCategory(widget.transaction['category_id']).toString()),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              const BoxShadow(
                color: Color.fromARGB(255, 213, 210, 210),
                offset: Offset(1, 1),
                blurRadius: 3,
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 20,
            child: Icon(
              _banlacePos(widget.transaction['type'])!
                  ? Icons.arrow_downward_rounded
                  : Icons.arrow_upward_rounded,
              color: _banlacePos(widget.transaction['type'])!
                  ? Colors.green
                  : Colors.red,
            ),
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
        ),
        title: Text(
          _searchCategory(widget.transaction['category_id']).toString(),
          style: TextStyle(
            fontSize: sizeScreen * 0.027,
            fontWeight: FontWeight.bold,
          ),
        ),

        // FutureBuilder(
        //     future: getCategory(widget.transaction['category_id']),
        //     builder: (context, category) {
        //       return Text(
        //         category.data!.toString(),
        //         style: TextStyle(
        //           fontSize: sizeScreen * 0.027,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       );
        //     }),
        trailing: SizedBox(
          width: sizeScreen * 0.21,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                NumberFormat(' R\$ #.00', 'pt-BR').format(
                    widget.transaction['type'] == 1
                        ? widget.transaction['value']
                        : widget.transaction['value'] * -1),
                style: TextStyle(
                  color: _banlacePos(widget.transaction['type'])!
                      ? Colors.green
                      : Colors.red,
                  fontSize: sizeScreen * 0.027,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
