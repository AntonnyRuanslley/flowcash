import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class FormatValue {
  static getMoneyFormat(double value) {
    if (value == 0.0) {
      return "R\$ 0,00";
    } else {
      return NumberFormat(' R\$ #.00', 'pt-BR').format(value);
    }
  }

  static getSelectColor(double value) {
    if (value == 0.0) {
      return Colors.yellow[800];
    } else if (value > 0.0) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }
}
