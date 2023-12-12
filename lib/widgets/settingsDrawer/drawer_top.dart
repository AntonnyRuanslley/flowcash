import 'package:flutter/material.dart';

import '../../../utils/screen_size.dart';
import '../../themes/app_theme.dart';

class DrawerTop extends StatelessWidget {
  const DrawerTop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeScreen = ScreenSizes.getScreenHeightSize(context);
    return Container(
      width: sizeScreen * 1,
      color: AppTheme.primaryColor,
      padding: const EdgeInsets.all(9),
      child: Column(
        children: [
          CircleAvatar(
            radius: sizeScreen * 0.048,
            backgroundColor: AppTheme.secondyColor,
            child: Icon(Icons.settings,
                size: sizeScreen * 0.058, color: AppTheme.primaryColor),
          ),
          SizedBox(
            height: sizeScreen * 0.01,
          )
        ],
      ),
    );
  }
}
