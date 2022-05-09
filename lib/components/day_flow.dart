import 'package:cas/components/settings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayFlow extends StatefulWidget {
  Function selectedDate;
  DateTime oldDate;
  DayFlow(this.selectedDate, this.oldDate);

  @override
  State<DayFlow> createState() => _DayFlowState();
}

class _DayFlowState extends State<DayFlow> {
  DateTime? _inputDate;

  initState() {
    _inputDate = widget.oldDate;
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: widget.oldDate,
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
      locale: const Locale('pt', 'BR'),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _inputDate = pickedDate;
      });
      widget.selectedDate(_inputDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size.height;

    return Container(
      height: sizeScreen * 0.22,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.only(
            start: sizeScreen * 0.018,
            top: sizeScreen * 0.01,
            end: sizeScreen * 0.035),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () => Settings(),
                ),
                Text(
                  'Fluxo do dia:',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: sizeScreen * 0.042,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.date_range_outlined,
                        color: Colors.white,
                        size: sizeScreen * 0.04,
                      ),
                      onPressed: _showDatePicker,
                    ),
                    Text(
                      DateFormat("dd/MM/yy", "pt_BR").format(_inputDate!),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: sizeScreen * 0.035,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
