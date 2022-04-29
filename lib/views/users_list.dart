import '../components/user_file.dart';
import '../data/dummy_users.dart';

import 'package:flutter/material.dart';

class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  _removeUser(String id) {
    setState(() {
      DUMMY_USERS.removeWhere((user) => user.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Usuários cadastrados',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: DUMMY_USERS.length,
        itemBuilder: (ctx, i) =>
            UserFiles(DUMMY_USERS.elementAt(i), _removeUser),
      ),
    );
  }
}
