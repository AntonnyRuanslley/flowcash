import 'package:flutter/material.dart';

import '../../utils/format_value.dart';
import '../../utils/open_form.dart';
import '../../utils/screen_size.dart';
import '../../utils/search_category.dart';
import '../../views/transaction_information.dart';

class TransactionsTile extends StatefulWidget {
  final Map<String, dynamic> transaction;
  final Function() onRefresh;

  const TransactionsTile({
    Key? key,
    required this.transaction,
    required this.onRefresh,
  }) : super(key: key);

  @override
  State<TransactionsTile> createState() => _TransactionsTileState();
}

class _TransactionsTileState extends State<TransactionsTile> {
  @override
  Widget build(BuildContext context) {
    final sizeScreen = ScreenSizes.getScreenHeightSize(context);

    return TextButton(
      onPressed: () => openForm(
        context,
        TransactionInformation(
          transaction: widget.transaction,
          category:
              searchCategory(widget.transaction['category_id']).toString(),
          onRefresh: widget.onRefresh,
        ),
      ),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              const BoxShadow(
                color: Color.fromARGB(255, 213, 210, 210),
                offset: Offset(1, 1),
                blurRadius: 3,
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 20,
            child: Icon(
              widget.transaction['type'] == 1
                  ? Icons.arrow_downward_rounded
                  : Icons.arrow_upward_rounded,
              color: FormatValue.banlaceOrExpanse(widget.transaction['type']),
            ),
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
        ),
        title: Text(
          widget.transaction['description'],
          style: TextStyle(
            fontSize: sizeScreen * 0.025,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Text(
          searchCategory(widget.transaction['category_id']).toString(),
          style: TextStyle(
            fontSize: sizeScreen * 0.027,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: SizedBox(
          width: sizeScreen * 0.21,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                FormatValue.getMoneyFormat(widget.transaction['type'] == 1
                    ? widget.transaction['value']
                    : widget.transaction['value'] * -1),
                style: TextStyle(
                  color: FormatValue.banlaceOrExpanse(
                    widget.transaction['type'],
                  ),
                  fontSize: sizeScreen * 0.027,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
