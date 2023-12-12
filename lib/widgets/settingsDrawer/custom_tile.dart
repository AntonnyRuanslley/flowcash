import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() onTap;
  const CustomTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      iconColor: AppTheme.primaryColor,
      title: Text(
        title,
        style: TextStyle(color: AppTheme.primaryColor),
      ),
      onTap: onTap,
    );
  }
}
