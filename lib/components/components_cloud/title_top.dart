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
    final sizeScreen =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Container(
      height: sizeScreen * 0.19,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: sizeScreen * 0.01,
        ),
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
                SizedBox(width: sizeScreen * 0.02),
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
