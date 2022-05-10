import 'package:cas/components/user_widgets/user_information.dart';

import 'package:flutter/material.dart';

class UsersFile extends StatefulWidget {
  final user;

  UsersFile(this.user);

  @override
  State<UsersFile> createState() => _UsersFileState();
}

class _UsersFileState extends State<UsersFile> {
  _openInformation() {
    setState(() {
      showDialog(
          context: context,
          builder: (context) {
            return UserInformation(widget.user);
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _openInformation(),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(
            Icons.person,
            color: Colors.white,
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        title: Text(widget.user['name']),
        subtitle: Text(widget.user['email']),
      ),
    );
  }
}
