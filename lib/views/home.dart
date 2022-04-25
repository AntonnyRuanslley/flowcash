import 'package:cas/views/transactions_list.dart';
import 'package:cas/views/users_list.dart';
import 'package:cas/views/pendents_list.dart';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _actualView = 2;

  void _onBottom(int index) {
    setState(() {
      _actualView = index;
    });
  }

  final List<Widget> _views = <Widget>[
    UsersList(),
    TransactionsList(),
    PendentsList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: _views[_actualView],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Usuários',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_sharp),
            label: 'Movimentação',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Aprovar',
          ),
        ],
        currentIndex: _actualView,
        onTap: _onBottom,
      ),
    );
  }
}
