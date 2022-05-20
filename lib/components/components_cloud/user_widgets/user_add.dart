import 'package:cas/components/components_cloud/user_widgets/type_user.dart';

import 'package:cas/data/urls.dart';

import 'package:cas/utils/messages.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class UserAdd extends StatefulWidget {
  final Function onRefresh;

  UserAdd(this.onRefresh);

  @override
  State<UserAdd> createState() => _UserAddState();
}

class _UserAddState extends State<UserAdd> {
  final _inputName = TextEditingController();
  final _inputEmail = TextEditingController();
  final _inputPassword = TextEditingController();
  int _inputType = 1;

  _addType(int type) {
    setState(() {
      _inputType = type;
    });
  }

  Future<void> _postUser() async {
    var name = _inputName.text;
    var email = _inputEmail.text;
    var password = _inputPassword.text;
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      return;
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse(urls['users']!);
    var answer = await http.post(
      url,
      body: {
        "name": name,
        "email": email,
        "password": password,
        "administrator": _inputType.toString(),
      },
      headers: {
        "Authorization": "Bearer ${sharedPreferences.getString('token')}",
      },
    );
    if (answer.statusCode == 201) {
      widget.onRefresh();
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(userAdded);
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size.width;

    _decoration(
      String label,
    ) {
      return InputDecoration(
        hintText: label,
        hintStyle: TextStyle(
          fontSize: sizeScreen * 0.05,
          color: Colors.white54,
        ),
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

    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
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
          content: SizedBox(
            height: sizeScreen * 1,
            child: Padding(
              padding: EdgeInsets.all(sizeScreen * 0.01),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextField(
                    maxLines: 1,
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                    decoration: _decoration('Nome'),
                    controller: _inputName,
                  ),
                  TextField(
                    maxLines: 1,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                    decoration: _decoration('Email'),
                    controller: _inputEmail,
                  ),
                  TextField(
                    maxLines: 1,
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                    decoration: _decoration('Senha'),
                    controller: _inputPassword,
                  ),
                  SizedBox(
                    height: sizeScreen * 0.28,
                    child: TypeUser(_addType, true),
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
                                  color:
                                      Theme.of(context).colorScheme.secondary,
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
      ),
    );
  }
}
