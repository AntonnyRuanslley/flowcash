import 'package:cas/components/user_widgets/user_edit.dart';
import 'package:cas/data/urls.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserInformation extends StatefulWidget {
  final user;

  UserInformation(this.user);

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  Future<void> _deleteUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse("${urls['users']!}/${widget.user['id']}");
    var answer = await http.delete(
      url,
      headers: {
        "Authorization": "Bearer ${sharedPreferences.getString('token')}"
      },
    );
    if (answer.statusCode == 204) {
      print('excluiu');
    } else {
      print('deu merda');
    }
  }

  _openAlert(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deseja realmente excluir?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const [
                Text('O usuário será excluido permanentemente!'),
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
              child: const Text('Excluir'),
              onPressed: () {
                _deleteUser();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _openForm(context) {
    showDialog(
        context: context,
        builder: (context) {
          return UserEdit(widget.user);
        });
  }

  @override
  Widget build(BuildContext context) {
    final sizeSreen = MediaQuery.of(context).size.width;

    _information(String title, content) {
      return Container(
        height: sizeSreen * 0.15,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: sizeSreen * 0.051,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Text(
              content,
              style: TextStyle(
                fontSize: sizeSreen * 0.051,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      );
    }

    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        "Informações",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      content: SizedBox(
        height: sizeSreen * 0.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _information("Nome", widget.user['name']),
            _information("E-mail", widget.user['email'].toString()),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(
              left: sizeSreen * 0.03,
              right: sizeSreen * 0.03,
              bottom: sizeSreen * 0.03),
          child: SizedBox(
            width: sizeSreen * 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text(
                    'Excluir',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: sizeSreen * 0.051,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => _openAlert(context),
                ),
                SizedBox(width: sizeSreen * 0.03),
                TextButton(
                  child: Text(
                    'Editar',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: sizeSreen * 0.051,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => _openForm(context),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
