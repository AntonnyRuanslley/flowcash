import 'package:flowcash/themes/app_theme.dart';
import 'package:flowcash/utils/screen_size.dart';
import 'package:flutter/material.dart';

class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeScreen = ScreenSizes.getScreenHeightSize(context);

    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off_outlined,
              size: sizeScreen * 0.3,
              color: AppTheme.secondyColor,
            ),
            Text(
              'Sem conexão!',
              style: AppTheme.subtitle1(context).copyWith(
                fontSize: sizeScreen * 0.05,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
