import 'package:cas/utils/select_date_modal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayFlow extends StatelessWidget {
  final DateTime oldDate;
  final Function(DateTime) selectedDate;

  DayFlow(this.selectedDate, this.oldDate);

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
            onPressed:
                DateFormat("dd 'de' MMMM 'de' yyy", "pt_BR").format(oldDate) ==
                        DateFormat("dd 'de' MMMM 'de' yyy", "pt_BR")
                            .format(DateTime(2000))
                    ? null
                    : () {
                        selectedDate(oldDate.subtract(const Duration(days: 1)));
                      },
          ),
          Expanded(
            child: Container(
              child: TextButton(
                child: Text(
                  DateFormat("dd 'de' MMMM 'de' yyy", "pt_BR").format(oldDate),
                  style: TextStyle(
                    fontSize: sizeScreen * 0.028,
                    color: Colors.black,
                  ),
                ),
                onPressed: () => selectDateModal(
                  context: context,
                  oldDate: oldDate,
                  selectedDate: selectedDate,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              size: sizeScreen * 0.033,
            ),
            onPressed:
                DateFormat("dd 'de' MMMM 'de' yyy", "pt_BR").format(oldDate) ==
                        DateFormat("dd 'de' MMMM 'de' yyy", "pt_BR")
                            .format(DateTime.now())
                    ? null
                    : () {
                        selectedDate(oldDate.add(const Duration(days: 1)));
                      },
          ),
        ],
      ),
    );
  }
}
