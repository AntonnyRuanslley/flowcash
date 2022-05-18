import 'package:cas/loading.dart';
import 'package:cas/views/select.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('transactions');
  await Hive.openBox('categories');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color(0XFFB80099),
      ),
    );

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FlowCash',
        color: Color(0XFFB80099),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        theme: tema.copyWith(
          colorScheme: tema.colorScheme.copyWith(
            primary: Color(0XFFB80099),
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
        home: Select() //Loading(),
        );
  }
}
