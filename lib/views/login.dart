import 'dart:convert';
import 'package:cas/controllers/auth_controller.dart';
import 'package:cas/data/urls.dart';
import 'package:cas/themes/app_theme.dart';
import 'package:cas/utils/loading_alert.dart';
import 'package:cas/utils/screen_size.dart';
import 'package:cas/views/loading.dart';
import 'package:cas/views/select.dart';
import 'package:cas/widgets/loginPage/login_custom_input.dart';

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

  double _heightTextFild0 = 0.07;
  double _heightTextFild1 = 0.07;

  @override
  Widget build(BuildContext context) {
    final sizeScreen = ScreenSizes.getScreenHeightSize(context);

    _changeSize(int who, double size) {
      setState(() {
        if (who == 1) {
          _heightTextFild0 = size;
        } else {
          _heightTextFild1 = size;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ScreenSizes.getDeviceStatucBarHeight(context)),
            IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
                color: AppTheme.secondyColor,
                size: 30,
              ),
              onPressed: () async {
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                await sharedPreferences.remove('choice');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (contex) => Select(),
                  ),
                );
              },
            ),
            Expanded(
              child: Center(
                child: LayoutBuilder(builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(sizeScreen * 0.02),
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: sizeScreen * 0.07),
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LoginCustomInput(
                              controller: _inputEmail,
                              hintText: 'Insira seu email',
                              keyboardType: TextInputType.emailAddress,
                              heightTextFild: _heightTextFild0,
                              validator: (email) {
                                if (email == null || email.isEmpty) {
                                  _changeSize(1, 0.1);
                                  return 'Por favor, digite seu email!';
                                }
                                if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(_inputEmail.text)) {
                                  _changeSize(1, 0.1);
                                  return 'Email inválido!';
                                }
                                _changeSize(1, 0.07);
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            LoginCustomInput(
                              controller: _inputPassword,
                              hintText: 'Insira sua senha',
                              keyboardType: TextInputType.emailAddress,
                              heightTextFild: _heightTextFild1,
                              obscureText: !passwordVisibility,
                              validator: (password) {
                                if (password == null || password.isEmpty) {
                                  _changeSize(2, 0.1);

                                  return 'Por favor, digite sua senha!';
                                }
                                _changeSize(2, 0.07);
                                return null;
                              },
                            ),
                          ],
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
                                      loadingDialog(context, "Carregando...");
                                      AuthController.login(
                                        _inputEmail.text.trim(),
                                        _inputPassword.text.trim(),
                                        isChecked,
                                      ).then((result) {
                                        if (!currentFocus.hasPrimaryFocus) {
                                          currentFocus.unfocus();
                                        }
                                        Navigator.pop(context);
                                        if (result) {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Loading(),
                                            ),
                                          );
                                        } else {
                                          _inputPassword.clear();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(message);
                                        }
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
