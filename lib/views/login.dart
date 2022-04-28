import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passwordVisibility = true;
  bool isChecked = true;
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    final _inputUser = TextEditingController();
    final _inputPassword = TextEditingController();
    final width = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: SizedBox(
                      height: width * 0.35,
                      child: Image(
                        image: AssetImage(
                          'assets/images/lucros.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: width * 0.015),
                    height: width * 0.17,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: width * 0.07,
                          child: TextField(
                            maxLines: 1,
                            controller: _inputUser,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Insira seu email',
                              hintStyle: TextStyle(
                                fontSize: width * 0.03,
                              ),
                              contentPadding: EdgeInsets.only(
                                  left: width * 0.032,
                                  top: width * 0.07,
                                  bottom: width * 0.025,
                                  right: width * 0.05),
                              enabledBorder: UnderlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(width * 0.7),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(width * 0.7),
                              ),
                              filled: true,
                              fillColor:
                                  Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                        Container(
                          height: width * 0.07,
                          child: TextField(
                            maxLines: 1,
                            controller: _inputPassword,
                            obscureText: !passwordVisibility,
                            decoration: InputDecoration(
                              hintText: 'Insira sua senha',
                              hintStyle: TextStyle(
                                fontSize: width * 0.03,
                              ),
                              contentPadding: EdgeInsets.only(
                                  left: width * 0.032,
                                  top: width * 0.07,
                                  bottom: width * 0.025,
                                  right: width * 0.05),
                              enabledBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              filled: true,
                              fillColor:
                                  Theme.of(context).colorScheme.secondary,
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(right: width * 0.015),
                                child: InkWell(
                                  onTap: () => setState(
                                    () => passwordVisibility =
                                        !passwordVisibility,
                                  ),
                                  child: Icon(
                                    passwordVisibility
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    size: width * 0.036,
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
                        scale: width * 0.0015,
                        child: Checkbox(
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: width * 0.007),
                      Text(
                        'Salvar login?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.025,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: width * 0.02),
                    height: width * 0.055,
                    width: width * 1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.green,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            child: Text('Entrar',
                                style: TextStyle(
                                  fontSize: width * 0.027,
                                  color: Colors.white,
                                )),
                            onPressed: () {},
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
      ),
    );
  }
}
