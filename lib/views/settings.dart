import 'package:cas/components/components_local/category_widgets/category_add.dart';
import 'package:cas/utils/screen_size.dart';
import 'package:cas/views/categories_list.dart';
import 'package:cas/utils/open_form.dart';

import 'package:cas/views/loading.dart';
import 'package:cas/widgets/settingsDrawer/custom_tile.dart';
import 'package:cas/widgets/settingsDrawer/drawer_top.dart';

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

  @override
  Widget build(BuildContext context) {
    final sizeScreen = ScreenSizes.getScreenHeightSize(context);

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: SafeArea(
        child: Container(
          color: Colors.grey[50],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DrawerTop(),
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
              CustomTile(
                title: 'Adicionar categoria',
                icon: Icons.add,
                onTap: () => openForm(context, CategoryForm()),
              ),
              CustomTile(
                title: 'Editar categoria',
                icon: Icons.edit,
                onTap: () => openForm(context, CategoriesList(isEdit: true)),
              ),
              CustomTile(
                title: 'Excluir categoria',
                icon: Icons.delete,
                onTap: () => openForm(context, CategoriesList(isDelete: true)),
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomTile(
                      title: 'Escolher modo',
                      icon: Icons.low_priority_sharp,
                      onTap: () async {
                        bool changeChoice = await _changeChoice();
                        if (changeChoice) {
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
