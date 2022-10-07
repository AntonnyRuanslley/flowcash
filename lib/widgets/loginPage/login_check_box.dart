import 'package:cas/utils/screen_size.dart';
import 'package:flutter/material.dart';

class LoginCheckBox extends StatelessWidget {
  final bool isChecked;
  final Function onClick;
  const LoginCheckBox({
    Key? key,
    required this.isChecked,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Transform.scale(
          scale: ScreenSizes.getScreenHeightSize(context) * 0.0016,
          child: Checkbox(
            value: isChecked,
            onChanged: (value) {
              onClick(value!);
            },
          ),
        ),
        Text(
          'Salvar login?',
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenSizes.getScreenHeightSize(context) * 0.026,
          ),
        ),
      ],
    );
  }
}
