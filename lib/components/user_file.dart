import 'package:cas/models/user.dart';

import 'package:flutter/material.dart';

class UserFiles extends StatelessWidget {
  final User users;
  UserFiles(this.users);

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
          onPressed: () {},
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          )),
    );
  }
}
