import 'package:cas/loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Select extends StatelessWidget {
  const Select({Key? key}) : super(key: key);

  _onChoice(choice, context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (choice) {
      await sharedPreferences.setBool('choice', true);
    } else {
      await sharedPreferences.setBool('choice', false);
    }
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Loading()));
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: sizeScreen * 0.06),
              child: Column(
                children: [
                  SizedBox(
                    height: sizeScreen * 0.26,
                    child: Image(
                      image: AssetImage(
                        'assets/images/flowcash-icone-branco.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: sizeScreen * 0.025),
                  SizedBox(
                    height: sizeScreen * 0.07,
                    child: Image(
                      image: AssetImage(
                        'assets/images/flowcash-nome-branco.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Text(
                'Deseja qual tipo de armazenamento?',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: sizeScreen * 0.033,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: sizeScreen * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: sizeScreen * 0.065,
                  width: sizeScreen * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 2,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () => _onChoice(true, context),
                    child: Text(
                      "Nuvem",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: sizeScreen * 0.03),
                    ),
                  ),
                ),
                SizedBox(width: sizeScreen * 0.03),
                Container(
                  height: sizeScreen * 0.065,
                  width: sizeScreen * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 2,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () => _onChoice(false, context),
                    child: Text(
                      "Local",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: sizeScreen * 0.03),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
