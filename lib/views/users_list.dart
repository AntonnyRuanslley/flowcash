import 'dart:convert';
import 'dart:async';

import 'package:cas/data/urls.dart';
import 'package:cas/data/users.dart';

import '../components/user_file.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  List _users = [];
  Timer? timer;

  Future<void> getUsers() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse(urls['users']!);
    var answer = await http.get(
      url,
      headers: {
        "Authorization": "Bearer ${sharedPreferences.getString('token')}",
      },
    );
    if (answer.statusCode == 200) {
      setState(() {
        _users = jsonDecode(answer.body)['data'];
      });
    } else {
      return;
    }
  }

  @override
  void initState() {
    super.initState;
    getUsers();
    /*timer = Timer(
      const Duration(seconds: 3),
      () {
        Center(
            child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ));
      },
    );*/
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
      body: _users.isEmpty
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
              itemCount: _users.length,
              itemBuilder: (ctx, i) => UserFiles(_users.elementAt(i)),
            ),
    );
  }
}
