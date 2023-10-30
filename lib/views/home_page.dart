import 'package:flutter/material.dart';

import 'transactions_list_page.dart';
import '../views/users_list.dart';
import '../views/pendents_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _actualView = 1;

  _onBottom(int index) {
    setState(() {
      _actualView = index;
    });
  }

  final List<Widget> _views = <Widget>[
    UsersList(),
    TransactionsListPage(),
    PendentsList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _views[_actualView],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
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
