import 'package:cas/components/category_form.dart';
import 'package:cas/components/categorys_list.dart';
import 'package:cas/loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatelessWidget {
  Future<bool> _logoff() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    return true;
  }

  Future<bool> _deleteCategory() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    return true;
  }

  /*_openAlert(context, id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deseja realmente excluir?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const [
                Text('A transação será excluída permanentemente!'),
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
              onPressed: () async {
                _deleteCategory(id);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }*/

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
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: Icon(
                        Icons.person,
                        size: sizeScreen * 0.05,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    SizedBox(
                      height: sizeScreen * 0.01,
                    ),
                    Text(
                      'Usuário',
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
                  () => _openFormModal(context, CategoryForm())),
              _itemsDrawer(Icons.edit, 'Editar categoria',
                  () => _openFormModal(context, CategorysList())),
              _itemsDrawer(Icons.delete, 'Excluir categoria',
                  () => _openFormModal(context, CategorysList())),
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
                          Navigator.push(
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
