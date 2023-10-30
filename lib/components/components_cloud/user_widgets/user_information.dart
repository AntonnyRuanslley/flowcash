import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../utils/messages.dart';
import '../../../data/urls.dart';
import '../../../components/components_cloud/user_widgets/user_edit.dart';

class UserInformation extends StatefulWidget {
  final user;
  final Function onRefresh;

  UserInformation(this.user, this.onRefresh);

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  Future<void> _deleteUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse("${urls['users']!}/${widget.user['id']}/destroy");
    var answer = await http.post(
      url,
      headers: {
        "Authorization": "Bearer ${sharedPreferences.getString('token')}"
      },
    );
    if (answer.statusCode == 204) {
      widget.onRefresh();
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(userExcluded);
    } else {
      return;
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
          return Center(child: UserEdit(widget.user, widget.onRefresh, false));
        });
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size.width;

    _information(String title, content) {
      return Container(
        height: sizeScreen * 0.15,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: sizeScreen * 0.05,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Text(
              content,
              style: TextStyle(
                fontSize: sizeScreen * 0.05,
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
        height: sizeScreen * 0.3,
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
              left: sizeScreen * 0.03,
              right: sizeScreen * 0.03,
              bottom: sizeScreen * 0.03),
          child: SizedBox(
            width: sizeScreen * 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text(
                    'Excluir',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: sizeScreen * 0.051,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => _openAlert(context),
                ),
                SizedBox(width: sizeScreen * 0.03),
                TextButton(
                  child: Text(
                    'Editar',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: sizeScreen * 0.051,
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
