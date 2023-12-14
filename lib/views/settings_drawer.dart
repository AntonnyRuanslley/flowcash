import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/screen_size.dart';
import '../themes/app_theme.dart';
import '../services/settings_service.dart';
import '../routes/routes_names.dart';
import '../widgets/settingsDrawer/custom_tile.dart';
import '../widgets/settingsDrawer/drawer_top.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({
    Key? key,
  }) : super(key: key);

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
                title: 'Categorias',
                icon: Icons.edit,
                onTap: () => Get.toNamed(RoutesNames.categoriesPage),
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
                      onTap: () {
                        Get.find<SettingsService>()
                            .cleanChoice()
                            .then((changeChoice) {
                          if (changeChoice) {
                            Get.offAndToNamed(RoutesNames.splashScreenPage);
                          }
                        });
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
