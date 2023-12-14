import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  final double fontSize;
  final double imageSize;
  final Color color;
  const EmptyList({
    super.key,
    required this.fontSize,
    required this.imageSize,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            height: imageSize,
            child: Image(
              image: AssetImage(
                'assets/images/vazio.png',
              ),
              color: color,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          child: Text(
            'Sem categorias!',
            style: TextStyle(
              fontSize: fontSize,
              color: color,
            ),
          ),
        )
      ],
    );
  }
}
