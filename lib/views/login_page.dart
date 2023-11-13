import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../themes/app_theme.dart';
import '../utils/alert/alert_snack_bar.dart';
import '../utils/loading_alert.dart';
import '../utils/screen_size.dart';
import '../controllers/auth_controller.dart';
import '../views/loading.dart';
import 'selection.dart';
import '../widgets/loginPage/login_check_box.dart';
import '../widgets/loginPage/login_custom_button.dart';
import '../widgets/loginPage/login_custom_input.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                    builder: (contex) => SelectionPage(),
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
                        LoginCheckBox(
                            isChecked: isChecked,
                            onClick: (value) {
                              setState(() {
                                isChecked = value!;
                              });
                            }),
                        LoginCustomButton(
                          label: 'ENTRAR',
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
                                  alertSnackBar(
                                    context: context,
                                    message: "Email ou senha inválidos!",
                                    backgroundColor: Colors.red,
                                  );
                                }
                              });
                            }
                          },
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
