import 'package:cas/components/user_information.dart';
import 'package:cas/data/urls.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserFiles extends StatefulWidget {
  final user;

  UserFiles(this.user);

  @override
  State<UserFiles> createState() => _UserFilesState();
}

class _UserFilesState extends State<UserFiles> {
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
