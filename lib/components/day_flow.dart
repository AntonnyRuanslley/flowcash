import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayFlow extends StatefulWidget {
  final Function selectedDate;
  final DateTime oldDate;
  final Function _onDrawer;

  DayFlow(this.selectedDate, this.oldDate, this._onDrawer);

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
            top: sizeScreen * 0.01, end: sizeScreen * 0.025),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        onPressed: () {
                          widget._onDrawer();
                        }),
                    Text(
                      'Fluxo do dia:',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: sizeScreen * 0.042,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
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
