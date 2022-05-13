import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayFlow extends StatefulWidget {
  final Function selectedDate;
  final DateTime oldDate;
  final Function onDrawer;

  DayFlow(this.selectedDate, this.oldDate, this.onDrawer);

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
      height: sizeScreen * 0.25,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.only(
            top: sizeScreen * 0.01,
            end: MediaQuery.of(context).size.width * 0.04),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Theme.of(context).colorScheme.secondary,
                      size: sizeScreen * 0.045,
                    ),
                    onPressed: () {
                      widget.onDrawer();
                    }),
                Column(children: [
                  Text(
                    'Fluxo do dia',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: sizeScreen * 0.041,
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
                          fontSize: sizeScreen * 0.034,
                        ),
                      ),
                    ],
                  ),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
