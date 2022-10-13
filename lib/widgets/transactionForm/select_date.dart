import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectDate extends StatelessWidget {
  final Function() onPressed;
  final DateTime selectDate;

  const SelectDate({
    Key? key,
    required this.onPressed,
    required this.selectDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(
            Icons.date_range_outlined,
            color: Theme.of(context).colorScheme.secondary,
            size: sizeScreen * 0.082,
          ),
          onPressed: onPressed,
        ),
        Container(
          width: sizeScreen * 0.45,
          child: Text(
            'Data selecionada: ${DateFormat('dd/MM/y', "pt_BR").format(selectDate)}',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
