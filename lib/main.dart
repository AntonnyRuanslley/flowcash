import 'package:cas/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  /*SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var choice = sharedPreferences.getBool('choice');
  if (choice!) {*/
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('transactions');
  await Hive.openBox('categories');
  //}
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cast',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.purple[700],
          secondary: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: Loading(),
    );
  }
}
