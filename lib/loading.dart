import 'package:cas/data/users.dart';
import 'package:cas/views/select.dart';
import 'package:cas/views/transactions_list.dart';
import 'package:cas/views/transactions_list_local.dart';

import 'views/no_connection.dart';
import 'views/home.dart';
import 'views/login.dart';

import 'data/urls.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:io';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool? choice;

  Future<bool> _onLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString('token') == null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> _getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse(urls['user_logged']!);
    var answer = await http.get(url, headers: {
      "Authorization": "Bearer ${sharedPreferences.getString('token')}",
    });
    if (answer.statusCode == 200) {
      setState(() {
        user = jsonDecode(answer.body)['name'].toString();
      });
    }
    var isAdmin = jsonDecode(answer.body)['administrator'] as bool;
    return isAdmin;
  }

  Future<bool> _onChoice() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool('choice') == null) {
      return true;
    } else {
      choice = sharedPreferences.getBool('choice');
      return false;
    }
  }

  Future<bool> _tryConnection() async {
    try {
      final response = await InternetAddress.lookup(urls['testing_conection']!);
      return true;
    } on SocketException {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _onChoice().then((value) {
      if (value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Select()));
      } else {
        if (choice!) {
          _tryConnection().then((value) {
            if (value) {
              _onLogin().then((value) {
                if (value) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
                } else {
                  _getUser().then((value) {
                    if (value) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    } else {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TransactionsList()));
                    }
                  });
                }
              });
            } else {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => NoConnection()));
            }
          });
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => TransactionsListLocal()));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
