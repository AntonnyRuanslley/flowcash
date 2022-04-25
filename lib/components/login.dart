import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    bool isChecked = true;
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
            TextField(
              controller: _inputUser,
              //onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Insira seu email',
              ),
            ),
            TextField(
              controller: _inputPassword,
              //onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Insira sua senha',
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
                Text('Salvar login?'),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    child: Text('Entrar',
                        style: TextStyle(
                          fontSize: 16,
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
