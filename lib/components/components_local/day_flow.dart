import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayFlow extends StatefulWidget {
  final Function selectedDate;
  final DateTime oldDate;

  DayFlow(this.selectedDate, this.oldDate);

  @override
  State<DayFlow> createState() => _DayFlowState();
}

class _DayFlowState extends State<DayFlow> {
  DateTime? _inputDate;

  @override
  initState() {
    _inputDate = widget.oldDate;
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: widget.oldDate,
      firstDate: DateTime(2000),
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
    final sizeScreen =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return Container(
      height: sizeScreen * 0.055,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: sizeScreen * 0.033,
            ),
            onPressed: DateFormat("dd 'de' MMMM 'de' yyy", "pt_BR")
                        .format(_inputDate!) ==
                    DateFormat("dd 'de' MMMM 'de' yyy", "pt_BR")
                        .format(DateTime(2000))
                ? null
                : () {
                    setState(() {
                      _inputDate =
                          _inputDate!.subtract(const Duration(days: 1));
                    });
                    widget.selectedDate(_inputDate);
                  },
          ),
          Expanded(
            child: Container(
              child: TextButton(
                child: Text(
                  DateFormat("dd 'de' MMMM 'de' yyy", "pt_BR")
                      .format(_inputDate!),
                  style: TextStyle(
                    fontSize: sizeScreen * 0.028,
                    color: Colors.black,
                  ),
                ),
                onPressed: _showDatePicker,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              size: sizeScreen * 0.033,
            ),
            onPressed: DateFormat("dd 'de' MMMM 'de' yyy", "pt_BR")
                        .format(_inputDate!) ==
                    DateFormat("dd 'de' MMMM 'de' yyy", "pt_BR")
                        .format(DateTime.now())
                ? null
                : () {
                    setState(() {
                      _inputDate = _inputDate!.add(const Duration(days: 1));
                    });
                    widget.selectedDate(_inputDate);
                  },
          ),
        ],
      ),
    );
  }
}
