import 'package:cas/utils/screen_size.dart';
import 'package:flutter/material.dart';

class TitleTop extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const TitleTop({
    Key? key,
    required this.scaffoldKey,
  });

  @override
  State<TitleTop> createState() => _TitleTopState();
}

class _TitleTopState extends State<TitleTop> {
  @override
  Widget build(BuildContext context) {
    final sizeScreen =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Container(
      height: sizeScreen * 0.22,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Padding(
        padding: EdgeInsets.only(top: sizeScreen * 0.01),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Theme.of(context).colorScheme.secondary,
                    size: sizeScreen * 0.045,
                  ),
                  onPressed: () {
                    widget.scaffoldKey.currentState!.openDrawer();
                  },
                ),
                SizedBox(width: ScreenSizes.getScreenWidthSize(context) * 0.04),
                Container(
                  width: sizeScreen * 0.35,
                  child: const Image(
                    image: AssetImage(
                      'assets/images/flowcash-nome-branco.png',
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
