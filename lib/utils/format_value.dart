import 'package:intl/intl.dart';

class FormatValue {
  static getMoneyFormat(double value) {
    if (value == 0.0) {
      return "R\$ 0,00";
    } else {
      return NumberFormat(' R\$ #.00', 'pt-BR').format(value);
    }
  }
}
