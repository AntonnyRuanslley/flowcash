import 'package:flutter/material.dart';

import '../../widgets/transactionPage/transactions_tile.dart';
import '../../utils/screen_size.dart';

class TransactionsListBody extends StatelessWidget {
  final List<dynamic> transactions;
  final Function() onRefresh;
  const TransactionsListBody({
    Key? key,
    required this.transactions,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: transactions.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: ScreenSizes.getScreenHeightSize(context) * 0.25,
                  child: const Image(
                    image: AssetImage(
                      'assets/images/vazio.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  child: Text(
                    'Sem transações!',
                    style: TextStyle(
                      fontSize: ScreenSizes.getScreenHeightSize(context) * 0.05,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, i) {
                return TransactionsTile(
                  transaction: transactions[i],
                  onRefresh: onRefresh,
                );
              },
            ),
    );
  }
}
