import 'package:flutter/material.dart';

openForm(
  BuildContext context,
  Widget widget,
) {
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: widget,
      );
    },
  );
}
