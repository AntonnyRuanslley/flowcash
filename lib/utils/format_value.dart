import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class FormatValue {
  static getMoneyFormat(double value) {
    if (value == 0.0) {
      return NumberFormat(' R\$ 0.00', 'pt-BR').format(value);
    } else {
      return NumberFormat(' R\$ #.00', 'pt-BR').format(value);
    }
  }

  static getMoneyFormatNoFigures(double value) {
    if (value == 0.0) {
      return NumberFormat('0.00', 'pt-BR').format(value);
    } else {
      return NumberFormat('#.00', 'pt-BR').format(value);
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
