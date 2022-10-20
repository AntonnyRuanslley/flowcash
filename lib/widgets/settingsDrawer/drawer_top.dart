import 'package:cas/utils/screen_size.dart';
import 'package:flutter/material.dart';

class DrawerTop extends StatelessWidget {
  const DrawerTop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeScreen = ScreenSizes.getScreenHeightSize(context);
    return Container(
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
    );
  }
}
