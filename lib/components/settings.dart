import 'package:cas/loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  Future<bool> _logoff() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height;
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: size * 1,
            color: Theme.of(context).colorScheme.primary,
            child: TextButton(
              child: Text(
                'Logoff',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: size * 0.03),
              ),
              onPressed: () async {
                bool logoffed = await _logoff();
                if (logoffed) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (contex) => Loading(),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
