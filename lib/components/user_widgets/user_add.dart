import 'dart:convert';
import 'package:cas/data/urls.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class UserAdd extends StatefulWidget {
  @override
  State<UserAdd> createState() => _UserAddState();
}

class _UserAddState extends State<UserAdd> {
  final _inputName = TextEditingController();
  final _inputEmail = TextEditingController();
  final _inputPassword = TextEditingController();

  Future<void> _postUser() async {
    var name = _inputName.text;
    var email = _inputEmail.text;
    var password = _inputPassword.text;
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      return;
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse(urls['user_logged']!);
    var answer = await http.get(url, headers: {
      "Authorization": "Bearer ${sharedPreferences.getString('token')}",
    });
    if (answer.statusCode == 200) {
      url = Uri.parse(urls['users']!);
      answer = await http.post(
        url,
        body: {
          "name": name,
          "email": email,
          "password": password,
        },
        headers: {
          "Authorization": "Bearer ${sharedPreferences.getString('token')}",
        },
      );
      if (answer.statusCode == 201) {
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
        "Novo usuário",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          height: sizeSreen * 0.7,
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
                  decoration: _decoration('Nome'),
                  controller: _inputName,
                ),
                TextField(
                  maxLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                  decoration: _decoration('Email'),
                  controller: _inputEmail,
                ),
                TextField(
                  maxLines: 1,
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                  decoration: _decoration('Senha'),
                  controller: _inputPassword,
                  obscureText: true,
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
                          'Salvar',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: sizeSreen * 0.047,
                              fontWeight: FontWeight.bold),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                        ),
                        onPressed: () => _postUser(),
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
}
