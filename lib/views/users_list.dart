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
    final sizeScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Usuários cadastrados',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      body: DUMMY_USERS.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: sizeScreen * 0.01),
                    child: Container(
                        height: sizeScreen * 0.2,
                        child: Icon(
                          Icons.group_off_rounded,
                          size: sizeScreen * 0.2,
                        )),
                  ),
                  Container(
                    child: Text(
                      'Sem usuários!',
                      style: TextStyle(
                        fontSize: sizeScreen * 0.055,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: DUMMY_USERS.length,
              itemBuilder: (ctx, i) =>
                  UserFiles(DUMMY_USERS.elementAt(i), _removeUser),
            ),
    );
  }
}
