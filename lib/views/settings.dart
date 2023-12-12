import 'package:flowcash/routes/routes_names.dart';
import 'package:flowcash/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/screen_size.dart';
import '../utils/open_form.dart';
import '../views/categories_list.dart';
import '../views/category_form.dart';
import '../widgets/settingsDrawer/custom_tile.dart';
import '../widgets/settingsDrawer/drawer_top.dart';

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
      backgroundColor: AppTheme.primaryColor,
      child: SafeArea(
        child: Container(
          color: AppTheme.backgroundColor,
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
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: sizeScreen * 0.025,
                  ),
                ),
              ),
              CustomTile(
                title: 'Adicionar categoria',
                icon: Icons.add,
                onTap: () => openForm(CategoryForm()),
              ),
              CustomTile(
                title: 'Editar categoria',
                icon: Icons.edit,
                onTap: () => openForm(CategoriesList(isEdit: true)),
              ),
              CustomTile(
                title: 'Excluir categoria',
                icon: Icons.delete,
                onTap: () => openForm(CategoriesList(isDelete: true)),
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
                        final changeChoice = await _changeChoice();
                        if (changeChoice) {
                          Get.offAndToNamed(RoutesNames.splashScreenPage);
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
