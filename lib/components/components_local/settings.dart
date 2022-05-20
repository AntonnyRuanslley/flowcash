import 'package:cas/components/components_local/category_widgets/category_add.dart';
import 'package:cas/components/components_local//category_widgets/categories_list.dart';

import 'package:cas/loading.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<bool> _changeChoice() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove('choice');
    return true;
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
    final sizeScreen =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

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
                      radius: sizeScreen * 0.048,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: Icon(
                        Icons.settings,
                        size: sizeScreen * 0.058,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    SizedBox(
                      height: sizeScreen * 0.01,
                    )
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
                  () => _openFormModal(context, CategoryForm())),
              _itemsDrawer(Icons.edit, 'Editar categoria',
                  () => _openFormModal(context, CategoriesList(0))),
              _itemsDrawer(Icons.delete, 'Excluir categoria',
                  () => _openFormModal(context, CategoriesList(1))),
              Divider(
                height: 1,
                thickness: 1,
              ),
              /*Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _itemsDrawer(
                      Icons.low_priority_sharp,
                      'Escolher modo',
                      () async {
                        bool logoffed = await _changeChoice();
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
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
