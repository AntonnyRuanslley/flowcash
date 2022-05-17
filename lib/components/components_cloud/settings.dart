import 'dart:convert';

import 'package:cas/components/components_cloud/category_widgets/category_add.dart';
import 'package:cas/components/components_cloud/category_widgets/categories_list.dart';
import 'package:cas/components/components_cloud/user_widgets/user_edit.dart';

import 'package:cas/data/urls.dart';
import 'package:cas/data/users.dart';

import 'package:cas/loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<bool> _logoff() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove('token');
    //await sharedPreferences.remove('choice');
    return true;
  }

  Map user = {};

  Future<void> _getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse(urls['user_logged']!);
    var answer = await http.get(url, headers: {
      "Authorization": "Bearer ${sharedPreferences.getString('token')}",
    });
    setState(() {
      user = jsonDecode(answer.body);
    });
  }

  initState() {
    _refresh();
  }

  _refresh() {
    _getUser();
  }

  _openFormModal(context, widget) {
    showDialog(
        context: context,
        builder: (context) {
          return widget;
        });
  }

  @override
  Widget build(BuildContext context) {
    var sizeScreen = MediaQuery.of(context).size.height;

    _itemsDrawer(icon, text, onTap) {
      return ListTile(
        leading: Icon(icon),
        iconColor: Theme.of(context).colorScheme.primary,
        title: Text(
          text,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        onTap: onTap,
      );
    }

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: SafeArea(
        child: Container(
          color: Colors.grey[50],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: sizeScreen * 1,
                color: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.all(9),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: sizeScreen * 0.045,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: Icon(
                        Icons.person,
                        size: sizeScreen * 0.058,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    SizedBox(
                      height: sizeScreen * 0.01,
                    ),
                    Text(
                      nameUser,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: sizeScreen * 0.026),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                child: Text(
                  'Configurações',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                      fontSize: sizeScreen * 0.025),
                ),
              ),
              _itemsDrawer(Icons.add, 'Adicionar categoria',
                  () => _openFormModal(context, CategoryAdd())),
              _itemsDrawer(Icons.edit, 'Editar categoria',
                  () => _openFormModal(context, CategoriesList(0))),
              _itemsDrawer(Icons.delete, 'Excluir categoria',
                  () => _openFormModal(context, CategoriesList(1))),
              Divider(
                height: 1,
                thickness: 1,
              ),
              _itemsDrawer(
                  Icons.person,
                  'Editar perfil',
                  () =>
                      _openFormModal(context, UserEdit(user, _refresh, true))),
              Divider(
                height: 1,
                thickness: 1,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _itemsDrawer(
                      Icons.person_off,
                      'Sair',
                      () async {
                        bool logoffed = await _logoff();
                        if (logoffed) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (contex) => Loading(),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
