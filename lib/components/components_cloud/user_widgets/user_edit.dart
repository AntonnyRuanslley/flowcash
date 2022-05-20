import 'package:cas/components/components_cloud/user_widgets/type_user.dart';

import 'package:cas/data/urls.dart';

import 'package:cas/utils/messages.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class UserEdit extends StatefulWidget {
  final user;
  final Function onRefresh;
  final bool isPerfil;

  UserEdit(this.user, this.onRefresh, this.isPerfil);
  @override
  State<UserEdit> createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> {
  TextEditingController? _inputName = TextEditingController();
  TextEditingController? _inputPassword = TextEditingController();
  int? _inputType;

  void initState() {
    _inputName!.text = widget.user['name'];
    _inputType = widget.user['administrator'] == true ? 0 : 1;
  }

  _addType(int type) {
    setState(() {
      _inputType = type;
    });
  }

  Future<void> _putUser(isReset) async {
    var name = _inputName!.text;
    var password = _inputPassword!.text;
    if (isReset) {
      name = widget.user['name'];
      password = '123456789';
    }
    if (name.isEmpty) {
      return;
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse("${urls['users']!}/${widget.user['id']}/update");
    var answer = widget.isPerfil || password.isEmpty
        ? await http.post(
            url,
            body: {
              "name": name,
              "password": password,
              "administrator": _inputType.toString(),
            },
            headers: {
              "Authorization": "Bearer ${sharedPreferences.getString('token')}",
            },
          )
        : await http.post(
            url,
            body: {
              "name": name,
              "administrator": _inputType.toString(),
            },
            headers: {
              "Authorization": "Bearer ${sharedPreferences.getString('token')}",
            },
          );
    print(answer.statusCode);
    if (answer.statusCode == 200) {
      widget.onRefresh();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(userEditted);
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size.width;

    _decoration(String label) {
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
            "Edição de usuário",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          content: SizedBox(
            height: sizeScreen * (widget.isPerfil ? 0.55 : 0.8),
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
                    decoration: _decoration(widget.user['name']!),
                    controller: _inputName,
                  ),
                  widget.isPerfil
                      ? TextField(
                          maxLines: 1,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Theme.of(context).colorScheme.secondary,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                          decoration: _decoration("Inserir nova senha"),
                          controller: _inputPassword,
                          obscureText: true,
                        )
                      : Container(
                          width: sizeScreen * 1,
                          child: ElevatedButton(
                            onPressed: () => _openAlert(),
                            child: Text("Redefinir senha"),
                          ),
                        ),
                  !widget.isPerfil
                      ? SizedBox(
                          height: sizeScreen * 0.28,
                          child: TypeUser(_addType, true),
                        )
                      : Container(),
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
                          onPressed: () => _putUser(false),
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

  _openAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deseja realmente resetar a senha?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const [
                Text('O usuário pode não saber como logar novamente.'),
              ],
            ),
          ),
          actions: [
            TextButton(
                child: const Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            TextButton(
              child: const Text('Resetar'),
              onPressed: () {
                _putUser(true);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
