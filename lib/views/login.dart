import 'dart:convert';

import 'package:cas/data/urls.dart';
import 'package:cas/views/home.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  final _inputEmail = TextEditingController();
  final _inputPassword = TextEditingController();

  bool passwordVisibility = false;
  bool isChecked = true;

  var _heightTextFild0 = 0.07;
  var _heightTextFild1 = 0.07;
  var _heightContainer = 0.17;

  Future<bool> login() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse(urls['login']!);
    var answer = await http.post(
      url,
      body: {
        "email": _inputEmail.text,
        "password": _inputPassword.text,
      },
    );
    if (answer.statusCode == 200) {
      if (isChecked) {
        await sharedPreferences.setString(
            'token', jsonDecode(answer.body)['token'].toString().split('|')[1]);
      }
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size.height;

    _aligment() {
      return EdgeInsets.only(
          left: (sizeScreen * _heightTextFild0) * 0.55,
          top: (sizeScreen * _heightTextFild0) * 0.5,
          bottom: (sizeScreen * _heightTextFild0) * 0.27,
          right: (sizeScreen * _heightTextFild0) * 0.55);
    }

    _border() {
      return UnderlineInputBorder(
          borderRadius: BorderRadius.circular(sizeScreen * 0.7));
    }

    _changeSize(int who, double size) {
      setState(() {
        if (who == 1) {
          _heightTextFild0 = size;
        } else {
          _heightTextFild1 = size;
        }
        if (size == 0.1) {
          _heightContainer = 0.21;
        } else {
          _heightContainer = 0.17;
        }
      });
    }

    final message = SnackBar(
      content: Text(
        "Email ou senha são inválidos",
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.red,
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Form(
        key: _formkey,
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(sizeScreen * 0.02),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: sizeScreen * 0.07),
                  child: SizedBox(
                    height: sizeScreen * 0.32,
                    child: Image(
                      image: AssetImage(
                        'assets/icons/flowcash.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: sizeScreen * _heightContainer,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: sizeScreen * _heightTextFild0,
                        child: TextFormField(
                          maxLines: 1,
                          controller: _inputEmail,
                          keyboardType: TextInputType.emailAddress,
                          validator: (email) {
                            if (email == null || email.isEmpty) {
                              _changeSize(1, 0.1);
                              return 'Por favor, digite seu email!';
                            } else if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(_inputEmail.text)) {
                              _changeSize(1, 0.1);
                              return 'Email inválido!';
                            }
                            _changeSize(1, 0.07);
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Insira seu email',
                            hintStyle: TextStyle(
                              fontSize: sizeScreen * 0.03,
                            ),
                            contentPadding: _aligment(),
                            enabledBorder: _border(),
                            focusedBorder: _border(),
                            errorBorder: _border(),
                            focusedErrorBorder: _border(),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: sizeScreen * _heightTextFild1,
                        child: TextFormField(
                          maxLines: 1,
                          controller: _inputPassword,
                          validator: (password) {
                            if (password == null || password.isEmpty) {
                              _changeSize(2, 0.1);
                              return 'Por favor, digite sua senha!';
                            }
                            _changeSize(2, 0.07);
                            return null;
                          },
                          obscureText: !passwordVisibility,
                          decoration: InputDecoration(
                            hintText: 'Insira sua senha',
                            hintStyle: TextStyle(
                              fontSize: sizeScreen * 0.03,
                            ),
                            contentPadding: _aligment(),
                            enabledBorder: _border(),
                            focusedBorder: _border(),
                            errorBorder: _border(),
                            focusedErrorBorder: _border(),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.secondary,
                            suffixIcon: Padding(
                              padding:
                                  EdgeInsets.only(right: sizeScreen * 0.015),
                              child: InkWell(
                                onTap: () => setState(
                                  () =>
                                      passwordVisibility = !passwordVisibility,
                                ),
                                child: Icon(
                                  passwordVisibility
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: sizeScreen * 0.036,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Transform.scale(
                      scale: sizeScreen * 0.0016,
                      child: Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                    ),
                    Text(
                      'Salvar login?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: sizeScreen * 0.026,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: sizeScreen * 0.06,
                  width: sizeScreen * 1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.green,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          child: Text('ENTRAR',
                              style: TextStyle(
                                fontSize: sizeScreen * 0.027,
                                color: Colors.white,
                              )),
                          onPressed: () async {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (_formkey.currentState!.validate()) {
                              bool connect = await login();
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              if (connect) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Home(),
                                  ),
                                );
                              } else {
                                _inputPassword.clear();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(message);
                              }
                            }
                          },
                        ),
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
