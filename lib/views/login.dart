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
      body: Form(
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
                  height: width * 0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50,
                        padding: EdgeInsets.only(bottom: 2),
                        child: TextField(
                          maxLines: 1,
                          //onSubmitted: (_) => _submitForm(),
                          decoration: InputDecoration(
                            hintText: 'Insira seu email',
                            hintStyle: TextStyle(
                              fontSize: width * 0.03,
                            ),
                            contentPadding: EdgeInsets.only(
                                left: width * 0.04,
                                top: width * 0.07,
                                bottom: width * 0.025,
                                right: width * 0.05),
                            enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(width * 0.7),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(70),
                            ),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.secondary,
                          ),
                          controller: _inputUser,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 2),
                        height: 55,
                        child: TextField(
                          controller: _inputPassword,
                          obscureText: !passwordVisibility,
                          //onSubmitted: (_) => _submitForm(),
                          decoration: InputDecoration(
                            labelText: 'Insira sua senha',
                            enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.secondary,
                            suffixIcon: InkWell(
                              onTap: () => setState(
                                () => passwordVisibility = !passwordVisibility,
                              ),
                              child: Icon(
                                passwordVisibility
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: Theme.of(context).colorScheme.primary,
                                size: 20,
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
                    Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    Text(
                      'Salvar login?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        child: Text('Entrar',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            )),
                        style: TextButton.styleFrom(
                          //backgroundColor: Theme.of(context).colorScheme.primary,
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
