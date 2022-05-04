import 'views/no_connection.dart';
import 'views/home.dart';
import 'views/login.dart';
import 'data/urls.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:io';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Future<bool> _loginOn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString('token') == null) {
      return true;
    } else {
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
    _tryConnection().then((value) {
      if (value) {
        _loginOn().then((value) {
          if (value) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Login()));
          } else {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home()));
          }
        });
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => NoConnection()));
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
