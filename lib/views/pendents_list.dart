import '../data/transactions.dart';
import '../data/urls.dart';

import '../components/components_cloud/transaction_widgets/transactions_file.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PendentsList extends StatefulWidget {
  const PendentsList({Key? key}) : super(key: key);

  @override
  State<PendentsList> createState() => _PendentsListState();
}

class _PendentsListState extends State<PendentsList> {
  List _pendents = transactions;

  final message1 = SnackBar(
    content: Text(
      "Transações aprovadas!",
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.blueAccent,
  );
  final message2 = SnackBar(
    content: Text(
      "Algo deu errado, tente novamente!",
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.redAccent,
  );

  @override
  void initState() {
    super.initState();
    _pendents.removeWhere((tr) => tr['status'] == 2);
  }

  Future<void> _putTransaction(transaction) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse("${urls['transactions']!}/${transaction['id']}/update");
    var answer = await http.post(
      url,
      headers: {
        "Authorization": "Bearer ${sharedPreferences.getString('token')}",
      },
      body: {
        "description": transaction['description'],
        "category_id": transaction['category_id'].toString(),
        "value": transaction['value'].toString(),
        "type": transaction['type'].toString(),
        "status": 2.toString(),
        "date": transaction['date'].toString().split('T')[0],
        "user_id": transaction['user_id'].toString(),
      },
    );
    if (answer.statusCode == 200) {
      return;
    } else {
      return;
    }
  }

  _toApprove() {
    for (int i = 0; i < _pendents.length; i++) {
      _putTransaction(_pendents[i]);
    }
    setState(() {
      _pendents.clear();
    });
    if (_pendents.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(message1);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(message2);
    }
  }

  @override
  Widget build(BuildContext context) {
    var sizeScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transações pendentes',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      body: _pendents.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: sizeScreen * 0.01),
                    child: Container(
                      height: sizeScreen * 0.28,
                      child: const Image(
                        image: AssetImage(
                          'assets/images/vazio.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Sem pendencias!',
                      style: TextStyle(
                        fontSize: sizeScreen * 0.055,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: _pendents.length,
              itemBuilder: (ctx, i) =>
                  TransactionsFile(_pendents.elementAt(i), () {}, false),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.check,
        ),
        onPressed: () => _toApprove(),
        elevation: 8,
      ),
    );
  }
}
