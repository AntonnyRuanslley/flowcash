import 'package:flutter/material.dart';

selectDateModal({
  required BuildContext context,
  required DateTime oldDate,
  required Function(DateTime) selectedDate,
}) {
  showDatePicker(
    context: context,
    initialDate: oldDate,
    firstDate: DateTime(2000),
    lastDate: DateTime.now(),
    locale: const Locale('pt', 'BR'),
  ).then((pickedDate) {
    if (pickedDate == null) {
      return;
    }
    if (!FocusScope.of(context).hasPrimaryFocus) {
      FocusScope.of(context).unfocus();
    }
    selectedDate(pickedDate);
  });
}
