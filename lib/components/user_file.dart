import 'package:cas/models/user.dart';

import 'package:flutter/material.dart';

class UserFiles extends StatelessWidget {
  final User users;
  final Function(String) onRemove;

  UserFiles(this.users, this.onRemove);

  _openAlert(context, id) {
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
                Navigator.of(context).pop();
                onRemove(id);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(
          Icons.person,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      title: Text(users.name),
      subtitle: Text(users.email),
      trailing: IconButton(
          onPressed: () => _openAlert(context, users.id),
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          )),
    );
  }
}
