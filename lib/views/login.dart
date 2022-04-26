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
    final _inputUser = TextEditingController();
    final _inputPassword = TextEditingController();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(
                Icons.monetization_on,
                color: Colors.green,
                size: 150,
              ),
            ),
            Container(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 55,
                    padding: EdgeInsets.only(bottom: 2),
                    child: TextField(
                      controller: _inputUser,
                      //onSubmitted: (_) => _submitForm(),
                      decoration: InputDecoration(
                        labelText: 'Insira seu email',
                        enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(70),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(70),
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.secondary,
                      ),
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
    );
  }
}
