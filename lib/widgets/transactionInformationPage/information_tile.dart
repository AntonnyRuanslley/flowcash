import 'package:flutter/material.dart';

import '../../utils/screen_size.dart';

class InformationTile extends StatelessWidget {
  final String title;
  final String content;

  const InformationTile({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeScreen = ScreenSizes.getScreenWidthSize(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: sizeScreen * 0.051,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        Text(
          content,
          style: TextStyle(
            fontSize: sizeScreen * 0.051,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        SizedBox(height: sizeScreen * 0.03)
      ],
    );
  }
}
