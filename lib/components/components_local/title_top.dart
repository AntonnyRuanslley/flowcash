import 'package:flutter/material.dart';

class TitleTop extends StatefulWidget {
  final Function onDrawer;

  TitleTop(this.onDrawer);

  @override
  State<TitleTop> createState() => _TitleTopState();
}

class _TitleTopState extends State<TitleTop> {
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size.height;
    return Container(
      height: sizeScreen * 0.25,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.only(
            end: MediaQuery.of(context).size.width * 0.04),
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
                    widget.onDrawer();
                  },
                ),
                Container(
                  height: sizeScreen * 0.11,
                  width: MediaQuery.of(context).size.width * 0.6,
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
